CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-451410.trips_data_all.fhv_data`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://fhv_ny_data/fhv_tripdata_2019*.parquet']
);
