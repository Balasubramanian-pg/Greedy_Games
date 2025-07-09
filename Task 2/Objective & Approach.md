### **Situation & Objective**

#### **Situation**  
We have transaction data (`2_high_val_txn.csv`) with:  
- `adv_id`: Unique user identifier  
- `value_in_paise`: Transaction amount in paise (1 INR = 100 paise).  
- `created_at`: Timestamp of the transaction.  
- Other metadata (e.g., `payment_gateway`, `currency`, `status`).  

#### **Objective**  
Write an **SQL query** to flag transactions where:  
- The `value_in_paise` is **at least twice the average** of the user’s **previous 3 transactions**.  

**Why?**  
This detects:  
- **Unusual spending spikes** (potential fraud).  
- **System errors** (e.g., duplicate large charges).  

## Approach Taken

This SQL query identifies transactions where the current transaction value is at least twice the average of the user's previous three transactions. Here's how it works:

## Step-by-Step Breakdown

### 1. Creating the CTE (Common Table Expression) - `TransactionWithMovingAvg`

```sql
SELECT
    *,
    AVG(value_in_paise) OVER (
        PARTITION BY adv_id
        ORDER BY created_at
        ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
    ) AS avg_of_previous_3
FROM
    high_val_transactions
```

- **`PARTITION BY adv_id`**: Groups data by user ID, ensuring calculations are user-specific
- **`ORDER BY created_at`**: Arranges transactions chronologically for proper historical comparison
- **`ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING`**: Defines the window frame as:
  - Start: 3 rows before current row
  - End: 1 row before current row
  - This effectively selects exactly the 3 previous transactions

### 2. Main Query Filtering

```sql
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
    value_in_paise >= 2 * avg_of_previous_3
```

- Filters for transactions where current value is ≥ 2× the average of previous 3
- Returns key columns for analysis: user ID, transaction details, and payment info

## Highlights

1. **User-Specific Analysis**: The `PARTITION BY` ensures each user's transactions are analyzed independently
2. **Temporal Accuracy**: `ORDER BY created_at` guarantees proper chronological sequence
3. **Precise Window Frame**: `ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING` exactly captures the 3 transactions prior to the current one
4. **Implicit Handling of Edge Cases**:
   - For users with <3 transactions, `avg_of_previous_3` will be NULL
   - These are automatically excluded by the WHERE clause condition
