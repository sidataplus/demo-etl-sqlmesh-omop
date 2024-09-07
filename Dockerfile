# Use a minimal Python 3.11 runtime as a parent image
FROM python:3.11-slim

# Set environment variables to reduce the image size
ENV POETRY_VERSION=1.5.1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Poetry (for dependency management)
RUN pip install poetry==$POETRY_VERSION

# Copy only pyproject.toml and poetry.lock files to install dependencies first
COPY pyproject.toml ./

# Install Python dependencies via Poetry
RUN poetry install --no-root --no-dev

# Copy the rest of the project into the container (after dependencies are installed)
COPY ./sqlmesh_project /app/sqlmesh_project

# Set the working directory to the sqlmesh_project directory
WORKDIR /app/sqlmesh_project

# Expose any port the SQLMesh app uses (replace with the correct port if needed)
EXPOSE 8000

# Run SQLMesh application (adjust the entry point based on your SQLMesh setup)
CMD ["poetry", "run", "sqlmesh", "plan"]
