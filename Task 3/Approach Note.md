---

### Getting Started: Setting Up The environment

Firstly I **imported some essential Python libraries** like `pandas` (for handling data tables), `numpy` (for number crunching), and `datetime` (for working with dates and times). I also grabbed `matplotlib` and `seaborn` for later, just in case I needed to visualize anything.

Then, I **loaded the wallet transaction data** from the `3_wallet_data.csv` file into what I call a **DataFrame** – basically, a big table where I can easily organize and manipulate the information.

---

### What Am I Looking At?

Before jumping into heavy analysis, I did some basic reconnaissance.

* I **checked the shape of the dataset** to see how many rows (transactions) and columns (pieces of information about each transaction) I was dealing with.
* I **listed all the column names** so I knew exactly what kind of data was available.
* I **peeked at the first few rows** using `df.head()` to get a quick feel for the data's structure and content.
* To understand the **data types** (like numbers, text, or dates) and get some non-null counts, I ran `df.info()`. This is super helpful for spotting potential issues early on.
* I also asked for **basic statistics** like averages, minimums, maximums, and standard deviations for numerical columns using `df.describe()`. This gave me a quick sense of the data's distribution.

---

### Cleaning Up and Organizing Data

I noticed something important: the **'created_at' column wasn't in a proper date/time format**. That's like having a clock stuck at the wrong time! So, I **converted it to the correct datetime format** using `pd.to_datetime()`, making sure it could handle any weird mixed formats.

Then, I did a quick check on some key categories:
* I looked at the **`transaction_type`** to see if most transactions were debits or credits.
* I checked the **`currency` distribution** to ensure everything was as expected.
* And I examined the **`source_entity_type`** to understand where these transactions were originating from.

To make sure my future analysis was solid, I **sorted all the data**. I first grouped transactions by `adv_id` (which I figured was a unique user ID) and then by `created_at`. This way, all transactions for a single user were together and in chronological order – much easier to follow their financial story!

---

### Checking User-Level Profiles

I wanted to understand each user's behavior, not just individual transactions.

* I **created a user-level summary**, grouping all transactions by `adv_id`. For each user, I calculated things like:
    * **Total number of transactions** (`count`)
    * **Total amount** transacted (`sum`)
    * **Average transaction amount** (`mean`)
    * **Minimum and maximum transaction values**
    * The **earliest and latest transaction dates** for each user.
    * A breakdown of their **transaction types** (how many debits vs. credits).
    * How many **unique currencies** and **source entity types** they used.
* After generating this summary, the column names were a bit clunky, so I **flattened them out** to make them easier to read.

---

### Calculating Key Behavioral Metrics

With the user summaries in hand, I started calculating some crucial metrics that could hint at unusual behavior:

* I made clear columns for `total_transactions`, `total_amount`, and `avg_transaction`.
* I calculated the **date range** for each user's transactions (from their first to their last) and then figured out their **transaction frequency** (how many transactions per day). A super high frequency might be a red flag!
* I specifically **extracted the count of DEBIT and CREDIT transactions** for each user, which is vital for understanding money movement.
* From those counts, I calculated **debit and credit ratios** to see if a user was predominantly sending or receiving money.
* I also calculated the **total amount of DEBITs and CREDITs** separately for each user.
* Then, I computed the **net balance** (credits minus debits) and the **amount imbalance** (the absolute difference between total credits and debits). A large imbalance could mean unusual activity.

---

### Anomaly Detection

This is where the detective work really intensified. I wanted to find users whose behavior significantly deviated from the norm.

* **IQR Method for Outliers**: I used a statistical method called the **Interquartile Range (IQR)** to **identify statistical outliers** in key metrics like `total_amount`, `avg_transaction`, `txn_frequency`, and `amount_imbalance`. If a user's metric fell outside this "normal" range, I flagged them as an outlier.
* **Composite Anomaly Score**: To get a broader picture, I created a **composite anomaly score** for each user. This score increased by 1 for every outlier flag they received. The higher the score, the more "unusual" their behavior seemed across multiple metrics.
* I then identified **"high-risk users"** as those with an anomaly score of 2 or more.

---

### More Fraud Indicators and Statistical Checks

I wasn't done yet! I looked for other specific patterns:

* **Very high frequency/amount**: I flagged users whose transaction frequency or total amount was in the top 5% of all users.
* **Only debits or only credits**: This is a big one! Users who *only* send money or *only* receive money without a mix might be suspicious.
* **Z-Scores**: I calculated **Z-scores** for `total_amount`, `txn_frequency`, and `avg_transaction`. A Z-score tells me how many standard deviations away from the average a user's metric is. Users with Z-scores greater than 3 (meaning they're extremely far from the average) were flagged as "extreme users."

---

### Uncovering Unusual Patterns

Sometimes, the *when* of a transaction can be as important as the *what*.

* I **extracted the hour of the day and the day of the week** for each transaction. I also determined if a transaction occurred on a **weekend**.
* Then, I looked for **unusual timing patterns** at the user level, such as:
    * **Heavy weekend activity**: Users mostly transacting on weekends.
    * **Activity concentrated in very few hours**: Users who only transact during a very narrow window each day.
* I merged this timing data back into my main user statistics.

---

### Risk Scoring

Finally, I pulled all these threads together to create a **unified fraud risk score** for each user.

* I assigned weights to different indicators (like anomaly score, very high frequency, only debits/credits, unusual timing) and combined them. This score gave me a single number representing the overall risk level.
* Based on this score, I **classified users into risk categories**: Low, Medium, High, and Very High Risk.
* I then summarized the **distribution of users across these risk categories**.
* And, of course, I highlighted the **top 10 most suspicious users** based on their fraud risk score, showing their key metrics.
* I also provided a **summary of how many users exhibited each specific fraud indicator** (e.g., how many had only debit transactions).
* Finally, I did a **detailed analysis of the high-risk users** to understand their average behavior.

---
