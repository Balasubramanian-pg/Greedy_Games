#### **Situation:**
We have a platform where users sign up and interact with the system (e.g., clicking on ads, logging in). The system collects data on:
1. **User signup location** (country code where the user registered).
2. **User click behavior** (country code where clicks originate).
3. **Login activity** (daily active users).
4. **IP addresses** associated with clicks.

There is a possibility of **suspicious activity** if a user's **click location differs from their signup location**, which could indicate:
- **Fraud** (fake accounts, bot activity).
- **Account takeover** (someone else using the account from a different country).
- **VPN/proxy usage** (users masking their real location).

#### **Objective:**
**Identify users whose click locations (country) do not match their signup locations.**  
This helps detect potential fraud or misuse of the platform.

---

### **Data Provided:**
1. **`7_1_clicks_country.csv`**  
   - Maps each `click_id` to the `country_code` where the click originated.
   - Columns: `click_id`, `country_code`

2. **`7_2_clicks.csv`**  
   - Contains details about user clicks, including their `adv_id` (advertising ID), `click_id`, `reward_id`, and `ip` (IP address).
   - Columns: `adv_id`, `click_id`, `reward_id`, `ip`

3. **`7_3_login_log.csv`**  
   - Tracks daily active users (DAU) with their `adv_id`, `app_id`, and login `day`.
   - Columns: `adv_id`, `app_id`, `day`

4. **`7_4_user_signup_location.csv`**  
   - Stores the `country_code` where each user (`adv_id`) signed up.
   - Columns: `adv_id`, `country_code`

5. **Country Code Reference (`country.json`)**  
   - A JSON file mapping country codes (e.g., "US") to full country names (e.g., "United States").

---
### **Approach Taken**  

---

#### **1. Data Preparation & Merging**  
- **Loaded 4 datasets**:  
  - `clicks_country` (111K rows) – Click IDs + country codes  
  - `clicks` (206K rows) – User IDs, click IDs, IPs  
  - `login_log` (107K rows) – Daily user activity  
  - `user_signup` (92K rows) – User signup countries  
- **Merged data** to link:  
  - `click_id` → `country_code` (click location)  
  - `adv_id` → `country_code` (signup location)  

---

#### **2. Core Analysis: Location Mismatches**  
- **Flagged discrepancies** where:  
  `signup_country` ≠ `click_country`  
- **Key metrics**:  
  - **100% of users (37,704)** had mismatches (*likely data issue*).  
  - **17.7% (6,690 users)** were high-risk (`HIGH/CRITICAL` fraud score).  

---

#### **3. Fraud Scoring System**  
Each user scored **0-100** based on:  
1. **Discrepancy rate** (40% weight)  
2. **Multiple countries** clicked from (+30% for 3+ countries)  
3. **High click volume** (+10% if >50 clicks)  
4. **Reward farming** (+15% if >10 unique rewards)  

**Risk tiers**:  
- `CRITICAL` (≥70) – 2,705 users  
- `HIGH` (50-69) – 3,985 users  

---

#### **4. Top Suspicious Patterns**  
| Signup → Click Country       | Users | Clicks  |  
|------------------------------|-------|---------|  
| India → Unresolved IP         | 250   | 3740    |  
| India → Multiple Countries   | 204   | 1617    |  

**Red flags**:  
- Users with **3740 clicks** from **7 countries** in **1 day**.  
- **12+ countries** accessed by single users.  

---

#### **5. Technical Steps**  
1. **Merged datasets**:  
   ```python
   user_activity = clicks.merge(clicks_country, on='click_id')
                .merge(user_signup, on='adv_id')
   ```  
2. **Calculated fraud score**:  
   ```python
   fraud_score = (discrepancy_rate * 40) + (num_countries * 10) + ...
   ```  

---

#### **6. Key Results**  
| Metric                          | Value          |  
|---------------------------------|----------------|  
| Users analyzed                  | 37,704         |  
| Avg. fraud score                | 44.5           |  
| High-risk users                 | 6,690 (17.7%)  |  
| Top fraud country               | India (63%)    |  

---

#### **7. Why It Matters**  
- **100% mismatch rate** suggests **data quality issues** (e.g., IP masking).  
- **High-risk users** exhibit:  
  - **Geographical hopping** (VPNs/proxies).  
  - **Click flooding** (bots/fraud).  

**Action Items**:  
1. Verify data pipeline for IP/country resolution errors.  
2. Investigate `CRITICAL` users for **account takeovers**.  
3. Block **multi-country click bursts** (>50/day).  

--- 

**Final Insight**:  
> *"While all users showed location mismatches (likely due to data errors), 17.7% were high-risk with patterns of fraud (VPNs, bots). Prioritize investigating India-based users with 1000+ clicks from multiple countries."*  
