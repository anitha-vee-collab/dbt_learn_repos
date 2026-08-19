WITH claims AS(
    SELECT 
    claim_id ,
    employee_id ,
    claim_date,
    expense_type ,
    claimed_amt ,
    currency ,
    LOWER(approval_status) ,
    approver_id 
    FROM CLAIMS.RAW.expense_claims
)

SELECT * FROM claims