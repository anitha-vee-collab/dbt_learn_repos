{{ config(
    materialized='table',
    schema = 'cleansing'
    ) }}

with base as
(
    select * from {{ref('stg_ranked_claims')}}
),
dq_check AS (
    SELECT *,
        CASE
            WHEN ({{ check_null_conditions(['claim_id', 'employee_id', 'claimed_amt']) }}) THEN 'FAIL'
            ELSE 'PASS'
        END AS dq_status,
        CASE
            WHEN claimed_amt > 10000 AND expense_type IN ('TRAVEL', 'HOTEL') THEN 'VIOLATION'
            ELSE 'OK'
        END AS policy_violation_flag
    FROM base
)

SELECT
    claim_id,
    employee_id,
    claim_date,
    expense_type,
    claimed_amt,
    currency,
    approval_status,
    approver_id,
    dq_status,
    policy_violation_flag
FROM dq_check
WHERE dq_status = 'PASS'