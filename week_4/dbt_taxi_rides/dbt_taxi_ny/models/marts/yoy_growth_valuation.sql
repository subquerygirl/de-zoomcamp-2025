with yoy_growth as (
  select 
    service_type, 
    pickup_quarter, 
    yoy_growth,
    row_number() over(partition by service_type order by yoy_growth desc) as rn
  from {{ ref('fct_taxi_trips_quarterly_revenue') }}
  where pickup_year = 2020
)

select *,
    case when rn = 1 then 'best'
        when rn = 4 then 'worst'
        else 'middle'
    end as yoy_growth_valuation
from yoy_growth




