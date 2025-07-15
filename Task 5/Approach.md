## Data Preparation: Getting Started

First things first, I **loaded all four datasets** (`daily_login`, `referral_users`, `rev_referral`, `rev_overall`) into pandas DataFrames using `pd.read_csv()`. This is standard practice to bring the data into a usable format.

I then did a quick **overview of the dataset sizes** to understand how much data I was working with. This gives me a quick sense of scale.

After that, I focused on **data cleaning**:
* I **removed duplicate rows** from all DataFrames using `.drop_duplicates(inplace=True)` because duplicate records can skew analysis results and lead to inflated counts.
* I also **cleaned up column names** by removing any leading/trailing spaces using `.columns.str.strip()` to prevent potential merging issues or errors later on.

***

## User Segmentation: Who's Who?

My primary goal was to compare **referral users** to **non-referral users**.

* I **identified all unique user IDs (`adv_id`) from the referral users dataset** and stored them in a set called `referral_ids`. Sets are efficient for quick lookups.
* Then, I got **all unique user IDs from the overall revenue dataset** (`all_ids`).
* By subtracting the `referral_ids` from `all_ids`, I created `non_referral_ids`. This allowed me to clearly segment users based on whether they came through a referral or not.
* I then **merged the overall revenue data with this user classification** using `pd.DataFrame()` and `df.merge()` to add a flag (`is_referral`) to each user's revenue record. This was crucial for comparing revenue between the two groups.

***

## Revenue Analysis: Following the Money

With users clearly segmented, I dived into their revenue.

### Overall Revenue Summary
* I **separated the `revenue_class` DataFrame into two groups**: `referral_rev` and `non_referral_rev`, based on the `is_referral` flag.
* For both groups, I used `.describe()` on the `revenue_in_usd` column to get a **summary of their revenue distribution** (mean, min, max, quartiles). This gives a quick statistical overview of how much money each group is generating.
* I specifically noted the **number of "zero-revenue users"** in each group. This is important because users who generate no revenue still count towards user counts, affecting average revenue metrics.

### Revenue Segment Distribution
* I wanted to see **how revenue was distributed across different tiers** (Zero, Low, Medium, High revenue).
* I defined a `revenue_class` function to categorize revenue values into these segments.
* Then, I applied this function to both referral and non-referral revenue data and used `.value_counts()` to see the percentage of users falling into each segment. This helps visualize revenue concentration.

***

## RPU Comparison: The Bottom Line

Finally, I calculated and compared the **Revenue Per User (RPU)**.

* I calculated **RPU for referral users** by dividing their `total revenue` by their `total number of users`. I did the same for **non-referral users**.
* I then calculated the **absolute and percentage difference** between the two RPUs. This directly answers the question of which group performs better financially.
* My **final comparison table** brings together key metrics like total users, total revenue, average RPU, median revenue, and the percentage of zero-revenue users for both groups. This provides a comprehensive side-by-side view.

Based on the calculations, I could clearly state whether referral users generate more revenue per user than non-referral users, and by how much. This is the **key takeaway** for assessing the value of the referral program.
