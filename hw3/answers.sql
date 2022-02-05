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
