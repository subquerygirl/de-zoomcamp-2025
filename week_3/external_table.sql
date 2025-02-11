-- create external table
CREATE OR REPLACE EXTERNAL TABLE taxidata2024.taxidata_2024_01_06
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://taxi-data-2024/*.parquet']
);

--  create a materialized table
CREATE TABLE taxidata2024.taxidata_2024_01_06_materialised AS
SELECT * FROM `kestra-sandbox-449309.taxidata2024.taxidata_2024_01_06`;