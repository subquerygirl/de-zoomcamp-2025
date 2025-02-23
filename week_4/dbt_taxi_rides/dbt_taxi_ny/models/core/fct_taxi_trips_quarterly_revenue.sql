WITH quarterly_revenue AS (
    SELECT
        pickup_year,
        pickup_quarter,
        service_type,
        SUM(total_amount) AS revenue
    FROM {{ ref('fact_trips') }}
    GROUP BY pickup_year, pickup_quarter, service_type
),

yoy_growth AS (
    SELECT
        a.pickup_year,
        a.pickup_quarter,
        a.service_type,
        a.revenue,
        b.revenue AS prev_year_revenue,
        SAFE_DIVIDE(a.revenue - b.revenue, b.revenue) * 100 AS yoy_growth
    FROM quarterly_revenue a
    LEFT JOIN quarterly_revenue b
        ON a.service_type = b.service_type
        AND a.pickup_quarter = b.pickup_quarter
        AND a.pickup_year = b.pickup_year + 1
)

SELECT *
FROM yoy_growth
ORDER BY service_type, pickup_year, pickup_quarter
