
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `vs-dtc-de.trips_data_all.external_fhv_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dtc_data_lake_vs-dtc-de/raw/fhv_2019-*.parquet']
);


-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE vs-dtc-de.trips_data_all.fhv_tripdata_non_partitoned AS
SELECT * FROM vs-dtc-de.trips_data_all.external_fhv_tripdata;

-- # Question 1: What is count for fhv vehicles data for year 2019
select count(1) from vs-dtc-de.trips_data_all.fhv_tripdata_non_partitoned
-- 42084899

-- # Question 2: How many distinct dispatching_base_num we have in fhv for 2019
select count(distinct dispatching_base_num) from vs-dtc-de.trips_data_all.fhv_tripdata_non_partitoned
-- 792

-- # Question 3: Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num

-- Partition by dropoff_datetime and Cluster by dispatching_base_num
CREATE OR REPLACE TABLE vs-dtc-de.trips_data_all.fhv_tripdata_partitoned_clustered
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM vs-dtc-de.trips_data_all.external_fhv_tripdata;

-- # Question 4: What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 
-- for dispatching_base_num B00987, B02060, B02279

CREATE OR REPLACE TABLE vs-dtc-de.trips_data_all.fhv_tripdata_partitoned_clustered_v2
PARTITION BY DATE(pickup_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM vs-dtc-de.trips_data_all.external_fhv_tripdata;

select count(*) from vs-dtc-de.trips_data_all.fhv_tripdata_partitoned_clustered_v2
WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
and dispatching_base_num in ('B00987', 'B02060', 'B02279');
-- Estimate: 400.1 MiB, Count - 26647 and Actual: 132.4 MB

-- # Question 5: What will be the best partitioning or clustering strategy when filtering on dispatching_base_num and SR_Flag
-- Review partitioning and clustering video. Clustering cannot be created on all data types.

-- No partition and no clustering
select count(*) from vs-dtc-de.trips_data_all.fhv_tripdata_non_partitoned where dispatching_base_num = 'B02883' and SR_Flag=18
-- This query will process 363 MiB when run.

-- Partition by SR_Flag (Integer values using Range_BUCKET) and Cluster by dispatching_base_num (alphanumeric)

 select min(SR_flag), max(SR_Flag) FROM vs-dtc-de.trips_data_all.external_fhv_tripdata;
 -- 1 to 43

CREATE OR REPLACE TABLE vs-dtc-de.trips_data_all.fhv_tripdata_partitoned_clustered_v3
PARTITION BY RANGE_BUCKET(SR_Flag, GENERATE_ARRAY(1, 50, 5))
CLUSTER BY dispatching_base_num AS
SELECT * FROM vs-dtc-de.trips_data_all.external_fhv_tripdata;

select count(*) from vs-dtc-de.trips_data_all.fhv_tripdata_partitoned_clustered_v3 where dispatching_base_num = 'B02883' and SR_Flag=18
-- This query will process 12.1 KiB when run. // More efficient

-- # Question 6: What improvements can be seen by partitioning and clustering for data size less than 1 GB
-- No improvements & Can be worse due to metadata due to small data size

-- # Question 7: In which format does BigQuery save data
-- Columnar