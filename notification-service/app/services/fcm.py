import firebase_admin
from firebase_admin import credentials, messaging
from app.config import get_settings

settings = get_settings()
_initialized = False


def init_firebase():
    global _initialized
    if _initialized:
        return

    cred = credentials.Certificate(settings.fcm_service_account_path)
    firebase_admin.initialize_app(cred)
    _initialized = True


def send_push_notification(
    fcm_token: str,
    title: str,
    body: str,
    data: dict | None = None
) -> bool:
    message = messaging.Message(
        notification=messaging.Notification(title=title, body=body),
        data=data or {},
        token=fcm_token,
    )

    try:
        response = messaging.send(message)
        print(f"FCM message sent: {response}")
        return True
    except messaging.UnregisteredError:
        print(f"FCM token is invalid or unregistered: {fcm_token[:20]}...")
        return False
    except Exception as e:
        print(f"FCM send error: {e}")
        return False
