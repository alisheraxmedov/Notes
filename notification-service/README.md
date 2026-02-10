# Notes Notification Service

Backend service for scheduling and sending push notifications for the Notes app.

## Quick Start

### Prerequisites

- Python 3.11+
- [uv](https://github.com/astral-sh/uv) package manager
- Firebase project with Cloud Messaging enabled

### Setup

1. **Install dependencies:**
   ```bash
   uv sync
   ```

2. **Add Firebase credentials:**
   
   Download `service-account.json` from Firebase Console:
   - Go to Project Settings → Service Accounts
   - Click "Generate new private key"
   - Save as `service-account.json` in project root

3. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env as needed
   ```

4. **Run the server:**
   ```bash
   uv run uvicorn app.main:app --reload --port 8008
   ```

5. **Open API docs:** http://localhost:8008/docs

## Docker

```bash
docker-compose up -d
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/schedule` | Schedule a notification |
| GET | `/schedule` | List pending notifications |
| GET | `/schedule/{id}` | Get notification details |
| DELETE | `/schedule/{id}` | Cancel notification |
| GET | `/health` | Health check |

## License

MIT
