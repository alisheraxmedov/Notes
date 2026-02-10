import logging
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import init_db, SessionLocal
from app.models import ScheduledNotification
from app.routes import notifications_router
from app.services import init_firebase, start_scheduler, stop_scheduler, is_scheduler_running
from app.schemas import HealthResponse
from app.config import get_settings

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("Starting up Notification Service...")
    init_db()
    init_firebase()
    start_scheduler()
    yield
    logger.info("Shutting down Notification Service...")
    stop_scheduler()


app = FastAPI(
    title="Notes Notification Service",
    description="Push notification scheduler for Notes app",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # TODO: Restrict this to your specific domain/IP in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(notifications_router)


@app.get("/health", response_model=HealthResponse, tags=["Health"])
async def health_check():
    db = SessionLocal()
    try:
        pending_count = db.query(ScheduledNotification).filter(
            ScheduledNotification.sent == False  # noqa: E712
        ).count()
        
        failed_count = db.query(ScheduledNotification).filter(
            ScheduledNotification.sent == True,  # noqa: E712
            ScheduledNotification.error_message != None  # noqa: E711
        ).count()
    finally:
        db.close()

    return HealthResponse(
        status="ok",
        scheduler_running=is_scheduler_running(),
        pending_notifications=pending_count,
        failed_notifications=failed_count,
    )
