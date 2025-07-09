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

### **Approach Taken**  

#### **1. Data Loading & Cleaning**  
- Imported datasets (`4_voting_data.csv`) and checked for missing values/duplicates.  
- Converted `created_at` to datetime for time-based analysis.  

#### **2. Sentiment Analysis**  
- Calculated **95.6% upvotes** vs. **4.4% downvotes** (21.7:1 ratio).  
- Identified **best/worst offers** by upvote rate (e.g., Offer ID 5272: 100% upvotes).  

#### **3. Geographic & Temporal Trends**  
- **Top country**: India (IN) with **1M+ votes** (95.6% upvotes).  
- **Peak activity**: Wednesdays and 3 AM/8 AM hours.  

#### **4. User & Offer Insights**  
- **User types**: 89.8% "Positive" voters.  
- **Offer quality**: 3 "A-grade" offers (score ≥80), 73 "D-grade" offers.  

#### **5. Advanced Metrics**  
- **Engagement depth**: Users interacting with ≥5 offers had **94.5% upvote rates**.  
- **Comment analysis**: Downvotes had **longer comments** (avg. 74 chars vs. 3 for upvotes).  

#### **6. Recommendations**  
- Scale **A-grade offers** and fix **D-grade offers**.  
- Target **IN users** during **peak hours (Wed, 3 AM/8 AM)**.  

**Bottom Line**:  
Your analysis reveals **strong positive sentiment**, with opportunities to optimize underperforming offers and regions. The referral program’s high engagement (95.6% upvotes) suggests it’s working well.  

---  
**Key Insight**:  
> *"Referral-driven users are highly satisfied (95.6% upvotes), but a few poorly rated offers (D-grade) need improvement to boost overall revenue."*  
