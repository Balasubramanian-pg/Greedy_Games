## 1. Initial Data Setup & Overview 
I started by **loading the `voting_data.csv` file** into a pandas DataFrame using `pd.read_csv()`. This is how I bring the raw data into my workspace.

Then, I did a **quick check of the data's shape** (rows and columns) and **listed all the column names**. This gives me an immediate understanding of the dataset's size and what information is available. I also **displayed the first few rows** using `.head()` to see a sample of the data.

To ensure data quality, I used `.info()` to **check data types** and identify any missing values. Importantly, I noticed the `created_at` column needed to be converted to a proper datetime format, so I used `pd.to_datetime()` for that. Lastly, `.describe()` provided **basic descriptive statistics** for numerical columns, like average vote count.

***

## 2. Overall Sentiment Analysis 
My first big question was, "Are people generally happy or unhappy?"
* I **counted the occurrences of 'UP' and 'DOWN' states** in the `state` column using `.value_counts()`. This showed me the raw numbers of upvotes and downvotes.
* From these counts, I calculated the **overall upvote and downvote percentages**, as well as the **sentiment ratio** (upvotes divided by downvotes). This gives a clear picture of the overall user sentiment towards offers.

***

## 3. Geographic Insights (Country-wise) 
I wanted to see if sentiment varied by location.
* I **grouped the data by `country_code`** using `groupby()` and then used `.agg()` to calculate the **total votes, upvotes, downvotes, unique users, and unique offers** for each country.
* I **calculated the `upvote_rate`, `downvote_rate`, and `sentiment_ratio` for each country**.
* Finally, I **displayed the top 10 countries by total vote volume** using `nlargest()`. This highlighted regions with the most active voting and their sentiment.

***

## 4. Offer Performance Analysis 
Next, I focused on the offers themselves. Which ones are loved, and which aren't?
* I **grouped data by `offer_id`** using `groupby()` and calculated **total votes, upvotes, downvotes, unique users, unique apps, and countries involved** for each offer.
* I then computed the **`upvote_rate` and `engagement_score`** (total votes per unique user) for each offer.
* I identified the **top 10 best and worst-performing offers** based on their `upvote_rate` using `nlargest()` and `nsmallest()`. This helps understand which offers are resonating with users and which are struggling.

***

## 5. App-Level Sentiment 
I also looked at how specific applications performed.
* I **grouped the data by `app_id`** using `groupby()` and calculated **total votes, upvotes, downvotes, unique users, and unique offers** for each app.
* I also computed the **`upvote_rate` for each app**. This shows which apps are generally hosting content that users like.

***

## 6. User Behavior Patterns (Who's Voting What?) 
Understanding user types is crucial.
* I **grouped data by `adv_id` (user ID)** using `groupby()` to get each user's **total votes, upvotes, downvotes, unique offers, and unique apps** they voted on.
* I calculated each user's **personal `upvote_rate`**.
* Based on their `upvote_rate`, I **categorized each user into 'Positive', 'Negative', or 'Neutral'** using a custom function. This helps segment the user base by their general voting tendency.
* I then showed the **distribution of these user sentiment types** to see the overall user satisfaction landscape.

***

## 7. Time-Based Trends 
When are users most active, and does sentiment change over time?
* I **extracted `date`, `hour`, `day_of_week`, and `month`** from the `created_at` column.
* I **analyzed daily sentiment trends** by grouping votes by `date` to see the `upvote_rate` fluctuations over time.
* I looked at **weekly voting patterns** by grouping by `day_of_week` to find the most active days and their average `upvote_rate`.
* I also examined **hourly voting patterns** by grouping by `hour` to identify peak voting times. This information can be useful for scheduling content.

***

## 8. Deep Dive into Engagement & Quality 
I went further to understand engagement depth and offer quality.
* I **analyzed geographic engagement levels** by categorizing countries based on their total vote volume (High, Medium, Low engagement).
* I developed an **offer quality score** based on `upvote_rate`, `total_votes`, and `unique_users`. Offers were then assigned a **quality grade (A, B, C, D)**. This provides a clear metric for overall offer performance.
* I performed a **cross-platform analysis** by grouping votes by both `app_id` and `country_code` to identify regional preferences for specific apps.
* I investigated **user engagement depth**, classifying users by how many unique offers they voted on (`Deep`, `Medium`, `Shallow` engagement) and their associated `upvote_rate`.
* I also calculated **voting velocity** (time between votes) for each user and checked how it differed between upvotes and downvotes. This could indicate rapid, potentially automated, voting behavior.
* Finally, I looked for **monthly voting trends** to identify any seasonal changes in activity or sentiment.

***

## 9. Key Insights & Recommendations 
I summarized my main findings, such as the overall positive sentiment, the most engaged country, and the best-performing offers.

Based on these insights, I developed **actionable recommendations**:
* **Focus on replicating success factors** from top-performing offers.
* **Optimize content for the most engaged country**.
* **Improve underperforming offers** to reduce negative sentiment.
* **Leverage peak activity days** for important launches.
* **Develop strategies for users with shallow engagement** to encourage deeper interaction.
* **Create region-specific content** based on identified preferences.

This comprehensive analysis helps understand user sentiment, identify high-performing elements, and pinpoint areas for improvement in the platform.
