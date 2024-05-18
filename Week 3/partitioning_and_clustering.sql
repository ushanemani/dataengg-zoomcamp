
CREATE TABLE  `dataengg-zoomcamp.trips_data_all.green_tripdata` as SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`;

INSERT INTO  `dataengg-zoomcamp.trips_data_all.green_tripdata`  SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`;

CREATE TABLE  `dataengg-zoomcamp.trips_data_all.yellow_tripdata` as SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`;

INSERT INTO  `dataengg-zoomcamp.trips_data_all.yellow_tripdata`  SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`;



-- Create a partitioned table from actual table
CREATE OR REPLACE TABLE `dataengg-zoomcamp.trips_data_all.yellow_tripdata_partitoned`
PARTITION BY
  DATE(pickup_datetime) AS
SELECT * FROM dataengg-zoomcamp.trips_data_all.yellow_tripdata;

-- Impact of partition
-- Scanning 73.13 MB of data instead of 1.12GB of data (full table)
SELECT DISTINCT(vendor_id)
FROM `dataengg-zoomcamp.trips_data_all.yellow_tripdata_partitoned`
WHERE DATE(pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';


-- Let's look into the partitons
SELECT table_name, partition_id, total_rows
FROM `trips_data_all.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_partitoned'
ORDER BY total_rows DESC;

-- Create a partitioned table and also cluster it using vendor_id 
--from actual yellow_tripdata table that has 2 years(2019,2020) data
CREATE OR REPLACE TABLE `dataengg-zoomcamp.trips_data_all.yellow_tripdata_partitioned_clustered`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY vendor_id AS
SELECT * FROM dataengg-zoomcamp.trips_data_all.yellow_tripdata;

-- Query scans 751 MB
SELECT count(*) as trips
FROM `dataengg-zoomcamp.trips_data_all.yellow_tripdata_partitoned`
WHERE DATE(pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31' AND vendor_id = "1";

-- Query scans 545 MB
SELECT count(*) as trips
FROM `dataengg-zoomcamp.trips_data_all.yellow_tripdata_partitioned_clustered`
WHERE DATE(pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND vendor_id = "1";




