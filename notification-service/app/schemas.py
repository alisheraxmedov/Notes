from pydantic import BaseModel
from datetime import datetime


class NotificationRequest(BaseModel):
    fcm_token: str
    title: str
    body: str
    scheduled_time: datetime
    note_id: int | None = None


class NotificationResponse(BaseModel):
    id: int
    message: str


class NotificationDetail(BaseModel):
    id: int
    fcm_token: str
    title: str
    body: str
    scheduled_time: datetime
    note_id: int | None
    sent: bool
    created_at: datetime
    sent_at: datetime | None

    class Config:
        from_attributes = True


class HealthResponse(BaseModel):
    status: str
    scheduler_running: bool
    pending_notifications: int
    failed_notifications: int
