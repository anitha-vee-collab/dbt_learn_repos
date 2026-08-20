{{ config(
    materialized='dynamic_table'
    , snowflake_warehouse = 'COMPUTE_WH'
    , database='SNOWFLAKE_DT'
    , schema='Transform_DT'
    , target_lag = 'DOWNSTREAM'
) }}

With customers_dt as
(
select cust_id,
 cust_name, 
 total_outstanding_amt, 
 CRID, 
 location, 
 CUST_CREATED_date
from SNOWFLAKE_DT.raw.customer
qualify row_number() over (partition by cust_id order by cust_created_date desc) = 1
)

select * from customers_dt