# Data Engineering Course

Course Reference Link: https://github.com/DataTalksClub/data-engineering-zoomcamp

**Data Talk Club: Data Engineering Course - Week 1 Summary:** [VS]
* Data Engineering Tools setup and Configuration - Git, Docker, Docker Compose, Postgres Database, Python, VS Code, Jupyter Notebooks, Terraform, GCP Account with Key services (GCS, BigQuery, Service Accounts etc.)
* Quick walkthrough of Datasets: NY Taxi Trips and Zone datasets
* Developed data ingestion scripts to download the datasets and load onto Postgres database using Python
* Containerized data ingestion scripts using Docker and Docker compose
* Terraform Scripts to setup and configure the key services from GCP Account
* Developed various SQL Queries for different scenarios using the datasets loaded onto Postgres Database

**Data Talk Club: Data Engineering Course - Week 2 Summary:** [VS]
* Data Engineering Tools setup and Configuration (New) - Apache Airflow, Jinja Template, GCP (Transfer Service, GCS, BigQuery) and AWS (S3)
* Data Lake Overview:
    - Central repository holds [Big]data from many sources (usually RAW data)
    - Data formats can be structured, semi-structured and unstructured
    - Usecases: Machine Learning, Stream Processing and Realtime Analytical
    - Users: Data Scientists and Data Analysts
    - Gotcha of Data Lake: Data Swamps, No Versioning, Incompatible Schemas, No Metadata and Joining datasets
* Data Warehouse Overview:
    - DWHs contain highly structured data that are cleansed, processed and refined.
    - Data formats generally structured
    - Use cases: Batch processing and BI Reports
    - Users: Business Analysts
    - Limitations: Smaller datasets (compare to Datalake), 
* ETL Vs ELT:
    - ETL: Suitable for DWH Solution, Small amount of data and Schema on WRITE
    - ELT: Suitable for Datalake Solution, Large amount of data and Schema on READ
* Apache Airflow:
    - Workflow engine that will easily schedule and run the complex data pipelines
    - Key Components: DAG (Directed Acyclic Graph), Scheduler, Executor, Worker, Metadata Database, Webserver and UI
    - Hands-on exercises covering creation, execution and monitoring of DAGs and Python scripts to download and ingest the various datasets into Google Cloud Storage and Postgres Database
* GCP - Transfer Service:
    - Data transfer from AWS (S3) to Google Cloud Storage using GCP Transfer Service UI or Terrafarm Script
    - Suitable for large volume of data migration (one-off usecase) on-prem/one cloud provider to other cloud provider
    - Sample cost estimation for Storage Transfer Service in GCP
