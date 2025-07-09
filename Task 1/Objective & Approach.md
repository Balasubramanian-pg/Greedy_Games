### **Situation & Objective**

#### **Situation**  
We have **user transaction data** from a wallet system, where each record includes:  
- `user_id`: Unique identifier for each user.  
- `transaction_amount`: Value of the transaction (e.g., in INR).  
- `transaction_time`: Timestamp when the transaction occurred.  

#### **Objective**  
Analyze user behavior **after their first transaction** to answer:  

1. **Time to Second Transaction**  
   - *"On average, how long does it take users to make their second transaction after the first?"*  
   - **Example**: If User A’s first transaction was at `10:00 AM` and their second at `2:00 PM`, the gap is **4 hours**.  

2. **User Retention Rate**  
   - *"What percentage of users who made a first transaction also made a second?"*  
   - **Example**: If 100 users made a first transaction and 75 made a second, the rate is **75%**.  

3. **Post-First Transaction Spending**  
   - *"What is the average transaction amount for users after their first transaction?"*  
   - **Example**: If a user’s subsequent transactions were `50, 100, 200 INR`, the average is `(50+100+200)/3 = 116.67 INR`.  

### **Approach Taken**
---

#### **1. Data Preparation & Exploration**
- **Loaded** transaction data (`1_txn_data.csv`) with **65,936 rows** and **13 columns**.
- **Key columns**:  
  - `adv_id`: Unique user identifier  
  - `value_in_paise`: Transaction amount (1 INR = 100 paise)  
  - `created_at`: Timestamp of transaction  
- **Cleaned data**:  
  - Converted `created_at` to datetime.  
  - Sorted by `adv_id` and `created_at` to ensure chronological order.  

---

#### **2. Key Questions Addressed**
##### **Q1: Average Time to Second Transaction**  
- **Approach**:  
  1. Identified each user’s **first** and **second** transactions.  
  2. Calculated time difference (in days) between them.  
  3. Computed the **mean** of these differences.  
- **Result**:  
  - **1.5 days** on average to make a second transaction.  

##### **Q2: Percentage of Users Making a Second Transaction**  
- **Approach**:  
  1. Counted users with **≥1 transaction** (`28,727`).  
  2. Counted users with **≥2 transactions** (`8,569`).  
  3. Calculated retention rate:  
     ```
     (Users with 2+ transactions) / (Users with 1+ transaction) × 100
     ```  
- **Result**:  
  - Only **14.04%** of users returned for a second transaction.  

##### **Q3: Average Transaction Amount After First Transaction**  
- **Approach**:  
  1. Isolated all transactions **after the first** (`37,187` records).  
  2. Converted `value_in_paise` to INR (`amount_inr`).  
  3. Calculated the **mean** of these amounts.  
- **Result**:  
  - **45.17 INR** average post-first transaction.  

---

#### **3. Advanced Insights**  
- **User Segmentation**:  
  - **20,158 users (70%)** made only **1 transaction**.  
  - **4,536 users (16%)** made **2 transactions**.  
  - **4,033 users (14%)** made **3+ transactions**.  
- **Payment Methods**:  
  - **UPI** dominated (48,173 transactions).  
  - **Gift cards** were second-most common (14,149).  
- **Fraud Indicators**:  
  - **Low retention (14%)** suggests poor engagement or potential fraud.  
  - **Large transaction spreads** (min: 5 INR, max: 500 INR) may indicate outliers.  

---

#### **4. Technical Implementation**  
- **Critical Steps**:  
  1. **Transaction Sequencing**:  
     ```python
     df['transaction_number'] = df.groupby('adv_id').cumcount() + 1
     ```  
  2. **Time Delta Calculation**:  
     ```python
     (second_txn_time - first_txn_time).dt.days
     ```  
  3. **Statistical Aggregation**:  
     ```python
     after_first_txns['amount_inr'].mean()
     ```  

---

#### **5. Key Findings**  
| Metric                                | Value             |  
|---------------------------------------|-------------------|  
| Avg. time to second transaction       | 1.5 days          |  
| % users making second transaction     | 14.04%            |  
| Avg. post-first transaction amount    | 45.17 INR         |  
| Users with only 1 transaction         | 20,158 (70%)      |  

**Why It Matters**:  
- **Low retention (14%)**: Signals potential onboarding issues or fake accounts.  
- **Rapid second transactions (1.5 days)**: Could indicate bot activity if clustered in seconds/minutes.  

**Recommendations**:  
- Investigate users with **>500 INR transactions** (potential fraud).  
- Improve engagement for **one-time users** (e.g., incentives for second transaction).  

--- 

**Final Insight**:  
> *"While most users (70%) transact only once, the 14% who return do so quickly (1.5 days) and spend moderately (45 INR on average). Focus on converting one-time users and monitoring rapid high-value transactions."*  
