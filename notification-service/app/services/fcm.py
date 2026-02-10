import firebase_admin
from firebase_admin import credentials, messaging
from firebase_admin.messaging import BatchResponse, SendResponse
import logging
from app.config import get_settings

settings = get_settings()
logger = logging.getLogger(__name__)
_initialized = False


def init_firebase():
    global _initialized
    if _initialized:
        return

    try:
        cred = credentials.Certificate(settings.fcm_service_account_path)
        firebase_admin.initialize_app(cred)
        _initialized = True
        logger.info("Firebase Admin initialized successfully")
    except Exception as e:
        logger.error(f"Failed to initialize Firebase: {e}")
        raise


def send_push_notification(
    fcm_token: str,
    title: str,
    body: str,
    data: dict | None = None
) -> bool:
    """
    Send a single push notification.
    Returns True if successful, False otherwise.
    """
    message = messaging.Message(
        notification=messaging.Notification(title=title, body=body),
        data=data or {},
        token=fcm_token,
    )

    try:
        response = messaging.send(message)
        logger.info(f"FCM message sent: {response}")
        return True
    except messaging.UnregisteredError:
        logger.warning(f"FCM token is invalid or unregistered: {fcm_token[:20]}...")
        return False
    except Exception as e:
        logger.error(f"FCM send error: {e}")
        return False


def send_batch_notifications(
    notifications: list[dict]
) -> list[tuple[bool, str | None]]:
    """
    Send a batch of notifications (up to 500).
    Input: list of dicts with keys: fcm_token, title, body, data
    Returns: list of tuples (success: bool, error_code: str | None)
    """
    if not notifications:
        return []

    messages = []
    for note in notifications:
        messages.append(
            messaging.Message(
                notification=messaging.Notification(
                    title=note["title"],
                    body=note["body"]
                ),
                data=note.get("data", {}),
                token=note["fcm_token"],
            )
        )

    try:
        batch_response: BatchResponse = messaging.send_each(messages)
        results = []

        for response in batch_response.responses:
            response: SendResponse
            if response.success:
                results.append((True, None))
            else:
                exception = response.exception
                error_code = exception.code if exception else "UNKNOWN"
                logger.error(f"Batch send error: {exception}")
                results.append((False, str(error_code)))

        logger.info(f"Batch sent: {batch_response.success_count} success, {batch_response.failure_count} failure")
        return results

    except Exception as e:
        logger.error(f"Critical batch send error: {e}")
        # Return all failed if batch call itself fails
        return [(False, str(e))] * len(notifications)
