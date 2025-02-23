
SELECT *
FROM {{ source('staging','fhv_data') }}
WHERE dispatching_base_num IS NOT NULL
