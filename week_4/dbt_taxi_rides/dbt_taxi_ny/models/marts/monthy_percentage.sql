SELECT 
    service_type,
    p97, 
    p95, 
    p90
FROM {{ ref('fct_taxi_trips_monthly_fare_p95') }}
WHERE pickup_year = 2020 AND pickup_month = 4;