{{
    config(
        materialized='table'
    )
}}

with green_tripdata as (
    select *, 
        'Green' as service_type
    from {{ ref('stg_green_tripdata') }}
), 
yellow_tripdata as (
    select *, 
        'Yellow' as service_type
    from {{ ref('stg_yellow_tripdata') }}
), 
trips_unioned as (
    select * from green_tripdata
    union all 
    select * from yellow_tripdata
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
),

add_zones as (
select trips_unioned.tripid, 
    trips_unioned.vendor_id, 
    trips_unioned.service_type,
    trips_unioned.rate_code, 
    trips_unioned.pickup_locationid, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    trips_unioned.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    trips_unioned.pickup_datetime, 
    trips_unioned.dropoff_datetime, 
    trips_unioned.store_and_fwd_flag, 
    trips_unioned.passenger_count, 
    trips_unioned.trip_distance, 
    trips_unioned.trip_type, 
    trips_unioned.fare_amount, 
    trips_unioned.extra, 
    trips_unioned.mta_tax, 
    trips_unioned.tip_amount, 
    trips_unioned.tolls_amount, 
    trips_unioned.ehail_fee, 
    trips_unioned.improvement_surcharge, 
    trips_unioned.total_amount, 
    trips_unioned.payment_type, 
    trips_unioned.payment_type_description
from trips_unioned
inner join dim_zones as pickup_zone
on trips_unioned.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trips_unioned.dropoff_locationid = dropoff_zone.locationid
),

add_date_dimensions as (
    select *,
        EXTRACT(YEAR FROM pickup_datetime) as pickup_year,
        EXTRACT(MONTH FROM pickup_datetime) AS pickup_month,
        CASE 
            WHEN EXTRACT(MONTH FROM pickup_datetime) BETWEEN 1 AND 3 THEN 'Q1'
            WHEN EXTRACT(MONTH FROM pickup_datetime) BETWEEN 4 AND 6 THEN 'Q2'
            WHEN EXTRACT(MONTH FROM pickup_datetime) BETWEEN 7 AND 9 THEN 'Q3'
            WHEN EXTRACT(MONTH FROM pickup_datetime) BETWEEN 10 AND 12 THEN 'Q4'
        END AS pickup_quarter,
    from add_zones
),

add_combination as (
    select *,
        CONCAT(pickup_year, '/', pickup_quarter) as pickup_year_quarter
    from add_date_dimensions
)

select *
from add_combination