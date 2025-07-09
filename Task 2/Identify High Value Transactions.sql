WITH TransactionWithMovingAvg AS (
    -- Step 1: Calculate the moving average for each transaction
    SELECT
        *, -- Select all original columns from the table
        AVG(value_in_paise) OVER (
            PARTITION BY adv_id
            ORDER BY created_at
            ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
        ) AS avg_of_previous_3
    FROM
        high_val_transactions
)
-- Step 2: Filter for transactions that meet the specified condition
SELECT
    adv_id,
    value_in_paise,
    avg_of_previous_3,
    created_at,
    payment_gateway,
    payment_status
FROM
    TransactionWithMovingAvg
WHERE
    value_in_paise >= 2 * avg_of_previous_3;
