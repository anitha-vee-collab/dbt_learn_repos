{{ config(
    materialized='table',
    database='CLAIMS',
    alias='DQ_CHECK_NULLS_EXPENSE_CLAIMS'
) }}

WITH dq_check AS (

    {{ check_nulls(
        ref('stg_expense_claims'),
        ['claim_id', 'employee_id', 'claimed_amt']
    ) }}

)

SELECT *
FROM dq_check
WHERE null_check_status = 'FAIL'