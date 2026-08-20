{{ config(
    materialized='dynamic_table'
    , snowflake_warehouse = 'COMPUTE_WH'
    , database='SNOWFLAKE_DT'
    , target_lag = '3 MINUTES'
    , schema='Transform_DT'
) }}

With cust_acc_dt as
(
select c.cust_id, 
c.cust_name, 
c.crid, 
c.location, 
c.cust_created_date,
a.acc_id, 
a.acc_category, 
a.acc_status, 
a.price, 
a.acc_count,
a.price / a.acc_count Price_Per_Accessory
from {{ ref('customer_dt') }} c, {{ ref('accessory_dt') }} a
where c.cust_id = a.cust_id
)
select * from cust_acc_dt