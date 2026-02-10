from fastapi import APIRouter, Depends, HTTPException, status, Security
from sqlalchemy.orm import Session
from datetime import datetime, timezone
from app.database import get_db
from app.models import ScheduledNotification
from app.schemas import NotificationRequest, NotificationResponse, NotificationDetail
from app.auth import get_api_key

router = APIRouter(prefix="/schedule", tags=["Notifications"])


@router.post("", response_model=NotificationResponse, status_code=status.HTTP_201_CREATED, dependencies=[Depends(get_api_key)])
async def schedule_notification(request: NotificationRequest, db: Session = Depends(get_db)):
    if request.scheduled_time.tzinfo is None:
        scheduled_utc = request.scheduled_time.replace(tzinfo=timezone.utc)
    else:
        scheduled_utc = request.scheduled_time.astimezone(timezone.utc)

    if scheduled_utc <= datetime.now(timezone.utc):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Scheduled time must be in the future"
        )

    notification = ScheduledNotification(
        fcm_token=request.fcm_token,
        title=request.title,
        body=request.body,
        scheduled_time=scheduled_utc,
        note_id=request.note_id,
    )

    db.add(notification)
    db.commit()
    db.refresh(notification)

    return NotificationResponse(id=notification.id, message="Notification scheduled")


@router.get("/{notification_id}", response_model=NotificationDetail, dependencies=[Depends(get_api_key)])
async def get_notification(notification_id: int, db: Session = Depends(get_db)):
    notification = db.query(ScheduledNotification).filter(
        ScheduledNotification.id == notification_id
    ).first()

    if not notification:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Notification not found"
        )

    return notification


@router.delete("/{notification_id}", status_code=status.HTTP_204_NO_CONTENT, dependencies=[Depends(get_api_key)])
async def cancel_notification(notification_id: int, db: Session = Depends(get_db)):
    notification = db.query(ScheduledNotification).filter(
        ScheduledNotification.id == notification_id
    ).first()

    if not notification:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Notification not found"
        )

    if notification.sent:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Cannot cancel already sent notification"
        )

    db.delete(notification)
    db.commit()


@router.get("", response_model=list[NotificationDetail], dependencies=[Depends(get_api_key)])
async def list_pending_notifications(
    fcm_token: str | None = None,
    db: Session = Depends(get_db)
):
    query = db.query(ScheduledNotification).filter(ScheduledNotification.sent == False)  # noqa: E712

    if fcm_token:
        query = query.filter(ScheduledNotification.fcm_token == fcm_token)

    return query.order_by(ScheduledNotification.scheduled_time).all()
