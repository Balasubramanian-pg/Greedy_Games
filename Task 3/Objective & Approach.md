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

### **Approach Taken**

#### **1. Data Preparation & Exploration**
- Loaded wallet transaction data (`3_wallet_data.csv`) with **1M+ rows**.
- Converted `created_at` to datetime for time-based analysis.
- Noted all transactions were **DEBITs** (money sent to users), with no CREDITs in this dataset.

#### **2. User-Level Feature Engineering**
Created metrics per user (`adv_id`):
- **Transaction counts/sums**: Total transactions, total amount, average transaction value.
- **Time patterns**: Date range, transactions/day frequency.
- **Debit analysis**: Since only DEBITs existed, focused on:
  - High-frequency DEBITs (>95th percentile).
  - Large DEBIT amounts (>3 standard deviations from mean).
  - Unusual timing (e.g., transactions clustered in few hours).

#### **3. Anomaly Detection**
- **IQR Method**: Flagged outliers in:
  - Total amount transacted.
  - Average transaction size.
  - Transaction frequency.
- **Z-Scores**: Identified extreme values (>3σ) in:
  - Amounts (`z_score_amount`).
  - Frequency (`z_score_frequency`).
- **Behavioral Flags**:
  - Users with **only DEBITs** (100% of cases here).
  - High weekend activity (`weekend_ratio > 0.8`).

#### **4. Risk Scoring**
Combined metrics into a **fraud risk score** (0–1 scale):
- **Weighted factors**:
  - Anomaly score (30% weight).
  - High frequency/amount (20% each).
  - Unusual timing (10%).
- **Risk tiers**:
  - **Very High Risk (8.96% of users)**: Extreme transaction patterns.
  - **High Risk (4.74%)**: Multiple red flags.
  - **Medium/Low Risk**: Minimal anomalies.

#### **5. Key Findings**
- **Top fraud indicators**:
  - **12,228 users** with high anomaly scores.
  - **68,004 users** with very high transaction frequency.
  - **136,476 users** with only DEBITs (all users in this dataset).
- **Example suspicious user**:
  - `adv_id: 00fed42c...` had **8 transactions/day** (vs. avg ~5), totaling **$5,941**.

#### **6. Why It Works for Fraud Detection**
- **Unusual DEBIT patterns** may indicate:
  - **Cash-out fraud**: Rapid withdrawals.
  - **Bot activity**: High-frequency transactions at odd hours.
- **Large amounts** could signal:
  - **Account takeover**: Sudden large withdrawals.
  - **Money laundering**: Structured transactions.

#### **7. Recommendations**
- **Immediate action**: Investigate **Very High Risk** users (12,228).
- **Monitoring**: Flag users with:
  - >5 transactions/day.
  - DEBITs > $1,000 (or other threshold).
  - Activity concentrated in <2 hours.

**Final Insight**:  
> *"8.96% of users exhibit very high-risk transaction patterns, primarily driven by high-frequency DEBITs. Focus on users with >5 transactions/day or amounts >3σ from the mean."*  
