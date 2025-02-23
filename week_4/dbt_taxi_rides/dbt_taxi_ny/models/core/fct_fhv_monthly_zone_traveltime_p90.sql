-- fct_fhv_monthly_zone_traveltime_p90.sql
SELECT 
    year,
    month,
    pickup_location_id,
    dropoff_location_id,
    APPROX_QUANTILES(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND), 100)[OFFSET(90)] AS p90_trip_duration
FROM {{ ref('dim_fhv_trips') }}
GROUP BY year, month, pickup_location_id, dropoff_location_id;
