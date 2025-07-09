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
