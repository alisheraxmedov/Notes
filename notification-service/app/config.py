from pydantic_settings import BaseSettings
from functools import lru_cache


class Settings(BaseSettings):
    database_url: str = "sqlite:///./data/notifications.db"
    fcm_service_account_path: str = "service-account.json"
    scheduler_interval_minutes: int = 1
    host: str = "0.0.0.0"
    port: int = 8008
    debug: bool = False
    api_key: str = ""
    max_retries: int = 3
    batch_size: int = 500

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


@lru_cache
def get_settings() -> Settings:
    return Settings()
