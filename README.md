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

**Data Talk Club: Data Engineering Course - Week 3 Summary:** [VS]
* Data Engineering Tools setup and Configuration (New) - GCP BigQuery (Cloud DWH)
* OLTP Vs OLAP:
    - OLTP: Transactional Databases, Small data volume, Normalized data, Frequent data updates and Data Backups are required for business continuity and to meet the regulatory requirements. Use cases - Databases used for eCommerce, CRM applications etc.
    - OLAP: Analytical/Reporting Databases, Large data volume, Normalized/De-normalized data, Frequent/Batch data updates and Usually backups are considered. Use cases - Data Warehouse (DWH) for BI Reports and Analytics
* Cloud DWH - GCP BigQuery Overview:
    - Serverless DWH, highly scalable and highly available. Storage and Compute can be scaled independently.
    - Key use cases: BI Reports, Machine Learning and Geospatial Analysis
    - Pricing: OnDemand Vs Flat rate pricing
* BigQuery - Partitions Overview:
    - Helps to improve the Query Performance and Optimize the Cost ($)
    - INFORMATION_SCHEMA.PARTITIONS helps to understand the data distributions across partitions and skew in the day.
    - Partition Key Candidates: Time-unit column, Ingestion time (_PARTITIONTIME), Integer Range Partitioning
    - Number of partitions limit is 4000 (expire partitioning strategy)
* BigQuery - Clustering Overview:
    - Columns you specify are used to co-locate related data. Clustering helps improve Query performance (Filters and Aggregates)
    - You can have up to 4 clustering columns per table
    - Example: Table data -> [Partitions (e.g., Pickup time)] -> Clustering (e.g., Vendor ID)
* BigQuery Clustering Vs Partitioning:
    - Cost Benefits (Unknown Vs Known upfront), Filter/Aggregation using (Multiple Columns Vs Single Column), Column Cardinality (High Vs Low) and Data Column(s) Update Frequency (High vs Low) 
    - Clustering over partitioning scenario: Partition results in a small amount of data per partition or when it reaches partition limits (4000) or frequent modification of partitions
    - BigQuery runs automatic re-clustering in background to restore the sort property of the table and no performance/cost impact.
* BigQuery Best Practices:
    - Cost Reduction - Avoid [SELECT *], Estimate the Price of the Query before running, Use clustered or partitioned tables, Use streaming inserts with caution and Materialize Query results in stages
    - Query Performance - Denormalize data, filter on partitioned columns, use nested or repeated columns, avoid oversharding, reduce data before JOIN, use approximate aggregation functions, optimize join patterns, Order Last etc.
* BigQuery Internals:
    - Google BigQuery Architecture Key Components - Dremel (Compute) executes SQL Queries, Colossus (Storage) stores data in columnar format and, Jupiter (Network) connects Dremel, and Colossus and Borg (Orchestration) is a precursor of Kubernetes
    - Column-oriented Vs Record-oriented Storage format. BigQuery uses a columnar storage format which results in faster aggregation, better data compression, improves SQL performance. 
    - Quick overview on how Dremel SQL Query execution tree/plan in a distributed environment using Mixer(s) and Leaf Node(s) <-> Colossus
* ML in BigQuery Build and Deployment:
    - BigQuery ML offers wide-range of ML models for different use cases (e.g., Customer Segmentation using K-Means, Product recommendation using Wide & Deep Classifier, Predict sales figures using Linear Regression, Personalization using Matrix factorization etc.)
    - ML model can be built using SQL with understanding of different ML Algorithms and No need to export DATA outside of BigQuery
    - Walkthrough of ML Dev Lifecycle and associated BigQuery features (including ML model deployment using Docker images) 
* Integration of BigQuery with Airflow:
    - Coding Workshop to show how we can use Airflow to automate the BigQuery tables creation based on the data ingested in the Google Cloud Storage (Data lake) using DAG with tasks like BigQueryCreateExternalTableOperator, BigQueryInsertJobOperator and GCStoGCSOperator