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
