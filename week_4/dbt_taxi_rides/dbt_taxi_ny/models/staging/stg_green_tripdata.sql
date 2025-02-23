
with tripdata as 
(
  select *,
    row_number() over(partition by vendor_id, pickup_datetime) as rn
  from {{ source('staging','green_tripdata') }}
  where vendor_id is not null 
),

clean_fields as (
  select
      -- identifiers
      {{ dbt_utils.generate_surrogate_key(['vendor_id', 'pickup_datetime']) }} as tripid,
      {{ dbt.safe_cast("vendor_id", api.Column.translate_type("integer")) }} as vendor_id,
      {{ dbt.safe_cast("rate_code", api.Column.translate_type("integer")) }} as rate_code,
      {{ dbt.safe_cast("pickup_location_id", api.Column.translate_type("integer")) }} as pickup_locationid,
      {{ dbt.safe_cast("dropoff_location_id", api.Column.translate_type("integer")) }} as dropoff_locationid,
      
      -- timestamps
      cast(pickup_datetime as timestamp) as pickup_datetime,
      cast(dropoff_datetime as timestamp) as dropoff_datetime,
      
      -- trip info
      store_and_fwd_flag,
      {{ dbt.safe_cast("passenger_count", api.Column.translate_type("integer")) }} as passenger_count,
      cast(trip_distance as numeric) as trip_distance,
      {{ dbt.safe_cast("trip_type", api.Column.translate_type("integer")) }} as trip_type,

      -- payment info
      cast(fare_amount as numeric) as fare_amount,
      cast(extra as numeric) as extra,
      cast(mta_tax as numeric) as mta_tax,
      cast(tip_amount as numeric) as tip_amount,
      cast(tolls_amount as numeric) as tolls_amount,
      cast(ehail_fee as numeric) as ehail_fee,
      cast(extra as numeric) as improvement_surcharge,
      cast(total_amount as numeric) as total_amount,
      CAST(CAST(payment_type AS FLOAT64) AS INT64) as payment_type
  from tripdata
  where rn = 1
)

select *,
    {{ get_payment_type_description("payment_type") }} as payment_type_description
from clean_fields


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}