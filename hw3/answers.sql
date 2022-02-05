-- 1. --

-- 42084899

create or replace external table `red-height-339014.trips_data_all.external_table_fhv`
options (
  format = 'Parquet',
  uris = ['gs://dtc_data_lake_red-height-339014/raw/fhv/fhv_tripdata_2019-*.parquet']
);

select count(1) from `red-height-339014.trips_data_all.external_table_fhv`;

-- 2. --

-- 792

select count(distinct dispatching_base_num) from `red-height-339014.trips_data_all.external_table_fhv`;

-- 3. --

-- Partition by dropoff_datetime and cluster by dispatching_base_num

create or replace table `red-height-339014.trips_data_all.external_table_fhv_part_clast_`
partition by date(dropoff_datetime)
cluster by dispatching_base_num as
select * from `red-height-339014.trips_data_all.external_table_fhv`;

select * from `red-height-339014.trips_data_all.external_table_fhv_part_clast_`;

-- 4. --

-- Count: 26558, Estimated data processed: 400 MB, Actual data processed: 155 MB

create or replace table `red-height-339014.trips_data_all.external_table_fhv_part_clast__`
partition by date(pickup_datetime)
cluster by dispatching_base_num as
select * from `red-height-339014.trips_data_all.external_table_fhv`;

select count(*) from `red-height-339014.trips_data_all.external_table_fhv_part_clast__`
where pickup_datetime between '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987', 'B02060', 'B02279');

-- 5. --

-- Cluster by dispatching_base_num and SR_Flag

create or replace table `red-height-339014.trips_data_all.external_table_fhv_part_clast__1`
cluster by dispatching_base_num, SR_Flag as
select * from `red-height-339014.trips_data_all.external_table_fhv`;

select count(*) from `red-height-339014.trips_data_all.external_table_fhv_part_clast__1`
where pickup_datetime between '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987', 'B02060', 'B02279');

-- 6. --

-- Huge improvement in data processed
-- Huge improvement in query performance

-- 7. --

-- Row
