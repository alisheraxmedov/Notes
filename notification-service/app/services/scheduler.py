from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.interval import IntervalTrigger
from datetime import datetime, timezone
from sqlalchemy.orm import Session
import logging

from app.database import SessionLocal
from app.models import ScheduledNotification
from app.config import get_settings

settings = get_settings()
scheduler = BackgroundScheduler()
logger = logging.getLogger(__name__)


def process_pending_notifications():
    db: Session = SessionLocal()
    try:
        now = datetime.now(timezone.utc)
        
        # Get batch of pending notifications
        # Filter by sent=False and retry_count < max_retries
        # Order by scheduled_time to process oldest first
        pending_notifications = db.query(ScheduledNotification).filter(
            ScheduledNotification.scheduled_time <= now,
            ScheduledNotification.sent == False,  # noqa: E712
            ScheduledNotification.retry_count < settings.max_retries
        ).order_by(ScheduledNotification.scheduled_time).limit(settings.batch_size).all()

        if not pending_notifications:
            return

        logger.info(f"Processing {len(pending_notifications)} pending notifications")

        # Prepare batch for FCM
        notifications_data = []
        for note in pending_notifications:
            notifications_data.append({
                "fcm_token": note.fcm_token,
                "title": note.title,
                "body": note.body,
                "data": {"note_id": str(note.note_id) if note.note_id else ""}
            })

        # Send batch
        if notifications_data:
            from app.services.fcm import send_batch_notifications
            results = send_batch_notifications(notifications_data)

            # Process results
            for note, (success, error_code) in zip(pending_notifications, results):
                if success:
                    note.sent = True
                    note.sent_at = datetime.now(timezone.utc)
                    note.error_message = None
                else:
                    # Handle failure
                    note.retry_count += 1
                    note.error_message = error_code
                    
                    # Check for permanent errors
                    if error_code in ["registration-token-not-registered", "invalid-argument"]:
                        logger.warning(f"Deleting invalid token notification: {note.id}")
                        db.delete(note)
                        continue

                    # Check max retries
                    if note.retry_count >= settings.max_retries:
                        logger.error(f"Max retries reached for notification {note.id}")
                        note.sent = True  # Mark as processed (failed)
                        note.error_message = f"{error_code} (Max retries reached)"

            db.commit()
            
    except Exception as e:
        logger.error(f"Scheduler error: {e}")
        db.rollback()
    finally:
        db.close()


def start_scheduler():
    if scheduler.running:
        return

    scheduler.add_job(
        process_pending_notifications,
        IntervalTrigger(minutes=settings.scheduler_interval_minutes),
        id="notification_processor",
        replace_existing=True,
    )
    scheduler.start()
    logger.info(f"Scheduler started (interval: {settings.scheduler_interval_minutes} min)")


def stop_scheduler():
    if scheduler.running:
        scheduler.shutdown()
        logger.info("Scheduler stopped")


def is_scheduler_running() -> bool:
    return scheduler.running
