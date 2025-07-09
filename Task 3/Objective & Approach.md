### **Situation & Objective**  

#### **Situation**  
We have **wallet transaction data** (`3_wallet_data.csv`) containing:  
- `adv_id`: Unique user identifier  
- `transaction_type`: **DEBIT** (money sent to user) or **CREDIT** (money sent to GreedyGame)  
- `value`: Transaction amount  
- `currency`: Currency type (e.g., USD, INR)  
- `source_entity_type`: Method used for the transaction (e.g., bank transfer, UPI)  
- `created_at`: Timestamp of the transaction  

#### **Objective**  
Identify **unusual wallet activity** that may indicate **fraud** by:  
1. **Flagging anomalies** in transaction patterns (e.g., sudden large withdrawals).  
2. **Comparing users** against typical behavior (e.g., average transaction frequency/amount).  
3. **Detecting red flags**:  
   - High-frequency DEBITs (rapid cash-outs).  
   - Unusual CREDIT-DEBIT loops (money cycling).  
   - Transactions from atypical `source_entity_type`.  
