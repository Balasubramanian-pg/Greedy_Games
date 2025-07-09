### **Situation & Objective**  

#### **Situation**  
We have **voting data** (`4_voting_data.csv`) from users who interacted with offers on the BharatCash app. Users can **upvote (UP)** or **downvote (DOWN)** an offer only after completing it, providing direct feedback on their experience.  

#### **Objective**  
Extract **key insights** from voting patterns to:  
1. **Measure offer quality** (Which offers are most liked/disliked?).  
2. **Understand user sentiment** (What % of votes are positive vs. negative?).  
3. **Identify engagement trends** (Do certain apps/offers get more votes?).  
4. **Detect regional biases** (Do users from specific countries vote differently?).  
5. **Analyze temporal trends** (Are votes increasing/decreasing over time?).  

### **Approach (Python Analysis Plan)**  
1. **Load & Clean Data**  
   - Check for missing values, duplicates, and standardize columns.  

2. **Basic Metrics**  
   - **Vote distribution**: % of upvotes vs. downvotes.  
   - **Top offers/apps** by vote count and sentiment ratio.  

3. **Advanced Insights**  
   - **Sentiment by country**: Compare `country_code` voting patterns.  
   - **Temporal analysis**: Votes per day/month to detect trends.  
   - **User engagement**: Most active voters (users with most votes).  

4. **Visualizations**  
   - Pie chart (UP vs. DOWN votes).  
   - Bar plots (top offers by sentiment).  
   - Heatmap (votes by country/time).  

**Expected Output**: Actionable insights to improve offers, target high-engagement regions, and optimize reward strategies.  
