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
