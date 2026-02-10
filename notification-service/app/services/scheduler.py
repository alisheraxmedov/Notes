from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.interval import IntervalTrigger
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.models import ScheduledNotification
from app.services.fcm import send_push_notification
from app.config import get_settings

settings = get_settings()
scheduler = BackgroundScheduler()


def process_pending_notifications():
    db: Session = SessionLocal()
    try:
        now = datetime.now(timezone.utc)

        pending = db.query(ScheduledNotification).filter(
            ScheduledNotification.scheduled_time <= now,
            ScheduledNotification.sent == False  # noqa: E712
        ).all()

        for notification in pending:
            success = send_push_notification(
                fcm_token=notification.fcm_token,
                title=notification.title,
                body=notification.body,
                data={"note_id": str(notification.note_id) if notification.note_id else ""},
            )

            if success:
                notification.sent = True
                notification.sent_at = now
                db.commit()
                print(f"Notification sent: {notification.title} (ID: {notification.id})")
            else:
                print(f"Failed to send notification ID: {notification.id}")
    except Exception as e:
        print(f"Scheduler error: {e}")
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
    print(f"Scheduler started (interval: {settings.scheduler_interval_minutes} min)")


def stop_scheduler():
    if scheduler.running:
        scheduler.shutdown()
        print("Scheduler stopped")


def is_scheduler_running() -> bool:
    return scheduler.running
