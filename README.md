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
Step 2: Install Dependencies
Install the required Python dependencies using Poetry:

bash
Copy code
poetry install
Step 3: Set Up Environment Variables
Create a .env file to protect your credentials. Add the following variables:

bash
Copy code
POSTGRES_USER=sqlmesh_user
POSTGRES_PASSWORD=sqlmesh_password
POSTGRES_DB=sqlmesh_db
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
Step 4: Docker Setup
Build and start the Docker containers:

bash
Copy code
docker-compose up --build
This will set up the PostgreSQL database and launch the SQLMesh application inside a Docker container.



Sample config.yaml
yaml
Copy code
gateways:
  local:
    connection:
      type: postgres
      host: postgres
      port: 5432
      database: dev_db
      user: dev_user
      password: dev_password

  prod:
    connection:
      type: postgres
      host: prod-db-host
      port: 5432
      database: prod_db
      user: prod_user
      password: prod_password

default_gateway: local


Contributing
If you would like to contribute to this project, please follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Commit your changes (git commit -m 'Add feature').
Push to the branch (git push origin feature-branch).
Open a Pull Request.
License
This project is licensed under the MIT License. See the LICENSE file for more information.

typescript
Copy code

This `README.md` covers the essential aspects of the project, including installation, usage, and configurat