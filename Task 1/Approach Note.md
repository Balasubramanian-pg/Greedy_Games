I started by **importing the necessary libraries**: pandas, numpy, and datetime. Next, I **loaded the data** into a DataFrame using `pd.read_csv`.

My initial step was **basic data exploration**. I checked the **shape of the dataset** and then used the `tolist()` function to see all the **column names**. To get a quick overview, I looked at the **first few rows** using `df.head()`. Before diving deeper, I needed to understand the **data types and basic information**, so I ran `df.info()`. It was also crucial to look at the **basic statistics** of the columns, which I did with `df.describe()`.

While exploring, I noticed that the 'created_at' column wasn't in datetime format, so I **converted it using `pd.to_datetime()`**. To ensure a structured approach, I decided to **sort the data** based on the date and the specific campaign or client using `df.sort_values()`.

To further organize my analysis, I **added a transaction sequence number for each user**. I then **checked the distribution of these transaction sequences** by using `groupby()` and `cumcount()+1`. Following that, I used `value_counts()` and `sort_index()` to see the **count for each transaction sequence distribution**.

Next, I **filtered out customers who initiated the first transaction** by applying a `df['transaction number'] == 1` filter. I then **created a separate copy** of this filtered data using `df[df['transaction number'] == 1].copy()`. I repeated this process for customers with a **second transaction** (using `== 2`) and then **merged both these DataFrames** using 'adv_id'. After merging, I **checked the first few rows** of the combined data to ensure everything looked correct.

A key part of my analysis was to **compute the day difference between the first and second transactions** using the `dt.days` function, which provided the difference in days. I then used the `.mean()` function to find the **average day difference**. To get the **percentage of users who made a second transaction**, I used the `len()` function on both the first and second transaction DataFrames and divided the length of the second by the first.

Afterward, I **checked the count of transactions after the first one**. I also **converted 'paise' to 'INR'** by dividing the relevant column by 100.

Finally, I **printed a summary of all my findings** and also **looked into additional facts** that supported my analysis needs.

---
