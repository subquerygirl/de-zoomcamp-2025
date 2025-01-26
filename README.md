# Data Engineering Zoomcamp - Week 1

This repository contains the work done for Week 1 of the "Data Engineering Zoomcamp" course. During this week, the focus was on getting hands-on experience with Docker, PostgreSQL, pgAdmin, and working with real-world datasets such as the NYC Taxi data.

## 🚀 Technologies Used
- **Docker**: Containerizing Postgres and pgAdmin for easy setup and portability.
- **PostgreSQL**: Database management system used to store and query the NYC Taxi data.
- **pgAdmin**: A web-based management tool for PostgreSQL.
- **pgcli**: A command-line client for PostgreSQL with auto-completion and syntax highlighting.
- **Terraform (Intro)**: Basic introduction to Terraform for provisioning and managing infrastructure as code with GCP.

## 📦 Project Overview

### Docker Setup
- The `docker-compose.yml` file defines two services:
  1. **PostgreSQL**: A container running PostgreSQL, storing the `ny_taxi` dataset.
  2. **pgAdmin**: A container running pgAdmin for managing the PostgreSQL database via a web interface.

### NYC Taxi Data
The NYC Taxi dataset is used to practice SQL queries in PostgreSQL and to set up PostgreSQL instances with Docker. The dataset is imported into the Postgres database for query testing and manipulation.

### Terraform Intro
- Basic Terraform scripts to provision and manage the infrastructure for this environment (ie., create a bucket, dataset).

## 📝 What I’ve Learned
- Hands-on with Docker: Setting up and connecting PostgreSQL and pgAdmin in containers.
- Postgres basics: Learning to work with PostgreSQL, including data import and running queries.
- Working with real-world data: Using NYC Taxi data for various queries and analyses.
- Intro to Terraform: Starting to learn how to use Terraform for infrastructure as code.
See [Notes](https://github.com/subquerygirl/de-zoomcamp-2025/blob/main/week_1/docker-postgres/notes.md)


## 🔜 Next Steps
- Moving forward, I will continue with further weeks of the Zoomcamp, focusing on additional data engineering concepts and technologies.
