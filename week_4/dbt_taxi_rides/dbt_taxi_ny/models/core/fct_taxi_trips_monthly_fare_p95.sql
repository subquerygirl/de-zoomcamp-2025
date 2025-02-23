SELECT 
    service_type,
    pickup_year,
    pickup_month,
    APPROX_QUANTILES(fare_amount, 100)[OFFSET(97)] AS p97,
    APPROX_QUANTILES(fare_amount, 100)[OFFSET(95)] AS p95,
    APPROX_QUANTILES(fare_amount, 100)[OFFSET(90)] AS p90
FROM {{ ref('fact_trips') }}
WHERE fare_amount > 0 
  AND trip_distance > 0
  AND payment_type_description IN ('Cash', 'Credit Card')
GROUP BY service_type, pickup_year, pickup_month
