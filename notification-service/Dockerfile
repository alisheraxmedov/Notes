FROM python:3.12-slim

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy project files
COPY pyproject.toml uv.lock* README.md ./

# Install dependencies (without project)
RUN uv sync --no-dev --no-install-project

# Copy application code
COPY . .

# Install project
RUN uv sync --no-dev

# Create data directory for SQLite
RUN mkdir -p /app/data

# Expose port
EXPOSE 8008

# Run the application
CMD ["uv", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8008"]

