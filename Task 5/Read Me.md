### 1. Situation (the ask)  
We need to compare the **Revenue Per User (RPU)** between two groups of users in the Bharat Cash app:  
- **Referred users**: Users who joined via a referral program.  
- **Non-referred users**: Users who joined organically (without referrals).  

#### **Data Available:**  
1. **`5_1_bharat_cash_overall_daily_login.csv`**  
   - Contains daily active users (DAU) with `adv_id` (user ID), `app_id`, and `day`.  
   - Helps identify **total users** who logged in.  

2. **`5_2_from_referral_bharatcash.csv`**  
   - Contains users who joined via referral (`referre_adv_id` and `created_at`).  
   - Helps identify **referred users**.  

3. **`5_3_rev_from_referral_bharatcash.csv`**  
   - Contains revenue generated **only by referred users** (`adv_id` and `revenue_in_usd`).  

4. **`5_4_rev_overall_bharatcash.csv`**  
   - Contains **total revenue** from all users (`adv_id` and `revenue_in_usd`).  

### **Objective:**  
Calculate:  
- **RPU for Referred Users** = (Total Revenue from Referrals) / (Number of Referred Users)  
- **RPU for Non-Referred Users** = (Total Revenue from Non-Referrals) / (Number of Non-Referred Users)  
- Compare the two RPUs to determine if referred users generate more revenue.  
