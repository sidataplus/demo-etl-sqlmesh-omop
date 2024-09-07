Here is the complete `README.md` file entirely in Markdown format:

```markdown
# Demo ETL with SQLMesh and OMOP

This repository demonstrates the use of **SQLMesh** for creating an ETL pipeline, transforming data into the **OMOP Common Data Model**. The ETL process involves extracting, transforming, and loading (ETL) data from different sources into the OMOP CDM structure, which is widely used in the healthcare industry.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Overview

The project provides an end-to-end ETL pipeline using SQLMesh to manage SQL transformations and handle versioning for SQL models. SQLMesh enables tracking and deploying SQL changes in development and production environments.

## Features

- SQL-based transformations using SQLMesh.
- Separate environments for development and production.
- Version control for SQL models and transformations.
- PostgreSQL as the database backend.
- Dockerized environment for easy setup.
- Integration with `.env` for credential security.

## Prerequisites

Before running this project, ensure you have the following tools installed:

- **Docker**: To run the database and application containers.
- **Poetry**: For Python dependency management.
- **Git**: To clone the repository and manage version control.

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/Chinapat0843/demo-etl-sqlmesh-omop.git
cd demo-etl-sqlmesh-omop
```

### Step 2: Install Dependencies

Install the required Python dependencies using **Poetry**:

```bash
poetry install
```

### Step 3: Set Up Environment Variables

Create a `.env` file to protect your credentials. Add the following variables:

```bash
POSTGRES_USER=sqlmesh_user
POSTGRES_PASSWORD=sqlmesh_password
POSTGRES_DB=sqlmesh_db
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
```

### Step 4: Docker Setup

Build and start the Docker containers:

```bash
docker-compose up --build
```

This will set up the PostgreSQL database and launch the SQLMesh application inside a Docker container.


## Configuration

The project uses a `config.yaml` file to configure SQLMesh for different environments (development and production).

### Sample `config.yaml`

```yaml
gateways:
  local:
    connection:
      type: postgres
      host: postgres
      port: 5432
      database: dev_db
      user: dev_user
      password: dev_password
default_gateway: local

model_defaults:
  dialect: postgres
  start: 2024-09-06


## Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

