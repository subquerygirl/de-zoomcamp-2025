# Data Engineering Zoomcamp - Week 1, 2 & 3

## 📖 About the Data Engineering Zoomcamp

The **Data Engineering Zoomcamp** is an intensive, hands-on course designed to teach the fundamentals of data engineering. It covers key concepts such as data ingestion, workflow orchestration, cloud computing, and infrastructure as code. The course is structured into multiple weeks, each focusing on specific tools and techniques essential for modern data engineering.

This repository contains my work and learnings from the first three weeks of the course, where I explored Docker, PostgreSQL, Terraform, Kestra, GCP, and BigQuery to build and manage data pipelines efficiently.

## 📂 Repository Structure

```
├── homework
│   ├── week_1
│   ├── week_2
│   └── week_3
├── week_1
│   ├── docker-postgres
│   ├── terraform
│   └── notes_week1.md
├── week_2
│   ├── kestra
│   ├── postgres
│   └── notes_week2.md
├── week_3
│   ├── download_script.yml
│   └── external_table.sql
└── README.md
```

- **homework/**: Includes assignments for Week 1, Week 2, and Week 3.
- **week_1/**: Contains all materials and exercises related to Week 1, including Docker, PostgreSQL, and Terraform introduction.
- **week_2/**: Covers Kestra workflow orchestration, GCP integration, ingestion pipelines, and scheduling/backfills.
- **week_3/**: Focuses on data warehousing, BigQuery, and query optimization best practices.

## 🚀 Technologies Used

### Week 1:

- **Docker**: Containerizing Postgres and pgAdmin for easy setup and portability.
- **PostgreSQL**: Database management system used to store and query the NYC Taxi data.
- **pgAdmin**: A web-based management tool for PostgreSQL.
- **pgcli**: A command-line client for PostgreSQL with auto-completion and syntax highlighting.
- **Terraform (Intro)**: Basic introduction to Terraform for provisioning and managing infrastructure as code with GCP.

### Week 2:

- **Kestra**: Orchestrating and managing workflows for data pipelines.
- **Google Cloud Platform (GCP)**: Cloud platform used for hosting and storing data.

### Week 3:

- **BigQuery**: Google’s fully managed data warehouse.

## 📦 Project Overview

### Week 1: Docker, Postgres & Terraform Intro

#### Docker Setup

- The `docker-compose.yml` file defines two services:
  1. **PostgreSQL**: A container running PostgreSQL, storing the `ny_taxi` dataset.
  2. **pgAdmin**: A container running pgAdmin for managing the PostgreSQL database via a web interface.

#### NYC Taxi Data

- The NYC Taxi dataset is used to practice SQL queries in PostgreSQL and to set up PostgreSQL instances with Docker.
- The dataset is imported into the Postgres database for query testing and manipulation.

#### Terraform Intro

- Basic Terraform scripts to provision and manage the infrastructure for this environment (e.g., create a bucket, dataset).

### Week 2: Kestra, GCP & Data Pipelines

#### Kestra Workflow

- Implemented workflow orchestration with Kestra to automate ingestion pipelines.
- Defined and executed tasks for data extraction, transformation, and loading (ETL).

#### GCP Integration

- Leveraged GCP storage and compute services for pipeline execution.

#### Ingestion Pipelines

- Built data ingestion pipelines to efficiently load and process data.
- Utilized batch processing techniques for structured data handling.

#### Scheduling & Backfills

- Configured schedules to automate recurring data processing tasks.
- Implemented backfill strategies to process historical data.

### Week 3: Data Warehousing & BigQuery

#### BigQuery Setup

- Configured a BigQuery dataset and loaded structured data for analysis.
- Understand external and materialised tables.

#### Query Optimization

- Implemented partitions and clustering strategies to improve performance.
- Estimated and analyzed query costs using best practices.

#### Performance Best Practices

- Learned about schema design, table partitioning, and clustering to optimize query execution.
- Used query execution plans to refine performance.

## 📝 What I’ve Learned

### Week 1:

- Hands-on with Docker: Setting up and connecting PostgreSQL and pgAdmin in containers.
- Postgres basics: Learning to work with PostgreSQL, including data import and running queries.
- Working with real-world data: Using NYC Taxi data for various queries and analyses.
- Intro to Terraform: Starting to learn how to use Terraform for infrastructure as code.

### Week 2:

- Workflow orchestration with Kestra for automating pipelines.
- Setting up and managing cloud-based data infrastructure on GCP.
- Designing and implementing efficient ingestion pipelines.
- Scheduling data pipelines and running backfills to process historical data.

### Week 3:

- Introduction to data warehousing concepts and best practices.
- Working with Google BigQuery for scalable analytics.
- Using partitions and clustering to optimize query performance.
- Understanding query execution plans and cost estimation.

## 🔜 Next Steps

- Moving forward, I will continue with further weeks of the Zoomcamp, focusing on additional data engineering concepts and technologies.