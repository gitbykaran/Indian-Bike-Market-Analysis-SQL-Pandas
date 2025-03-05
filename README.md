# Which Bike do Indians Prefers ?

![image](popular-bike-companies-in-india.png)

## Project Overview
This project analyzes the Indian bikes dataset using Python and SQL queries to extract valuable business insights. The dataset includes information on various motorcycle brands, models, engine specifications, pricing, and other key attributes. The analysis focuses on answering critical business questions related to sales trends, popular brands, engine capacities, and pricing distributions.

## Key Insights & Business Questions Answered
- **Which bike brands have the highest market presence?**
- **What are the most popular engine capacities among customers?**
- **How does pricing vary across different brands and engine sizes?**
- **What are the states with their price segments?**
- **Which Fuel Type Does People Prefers the most?**
- **Price Depriciation Among City Tiers?**
- **What is the Best Performing Year Revenue Wise for each Brand?**

## Tech Stack
- **Database:** MySQL
- **Query Language:** SQL
- **Python:** Pandas & Sqlalchamy

##  Dataset
The dataset includes:
- **Brand**: Manufacturer of the bike (e.g., Hero, Bajaj, Royal Enfield)
- **Model**: Specific bike model
- **Engine Capacity**: Measured in CC (cubic centimeters)
- **Power & Torque**: Performance metrics
- **Price**: Cost of the bike
- **Manufacturing Year**: Year of release
- **Registration Year**: Year of registration
- **State**: Name of State
- **Model**: Bike Model
- **City Tier**: City category (Tier1,Tier2 etc)

## 🔍 SQL Queries & Analysis
Below are some of the key SQL queries used in the analysis:

### Which bike brands have the highest market presence?
```sql
SELECT 
brand,
model,
COUNT(*) AS units_sold
FROM bikes
GROUP BY 1,2
ORDER BY 1 , 2 , 3 DESC
```

### What are the most popular engine capacities among customers for each state?
```sql
SELECT 
state,
ROUND(AVG(engine_capacity),0)
FROM bikes
GROUP BY 1 
```

###  How does pricing vary across different brands and engine sizes?
```sql
SELECT
brand,
model,
ROUND(AVG(mileage),0) avg_mileage_kmpl,
ROUND(AVG(engine_capacity),2) avg_engine_capacity_cc,
ROUND(AVG(price_inr),0) avg_price
FROM bikes
GROUP BY 1 ,2
```
###  Price Depriciation Among City Tiers?
```sql
WITH tier_price AS
(SELECT 
city_tier,
ROUND(AVG(price_inr),0) avg_bike_price,
ROUND(AVG(resale_price_inr),0) avg_bike_resale_price
FROM bikes
GROUP BY 1 
ORDER BY 1
)
SELECT 
*,
ROUND(((avg_bike_price-avg_bike_resale_price)/avg_bike_price) * 100,2) AS depreciation_percentage
FROM tier_price
```
### What is the Best Performing Year Revenue Wise for each Brand?
```sql
WITH Revenue_Brand AS 
(SELECT 
brand,
registration_year,
COUNT(*) * AVG(price_inr) revenue_inr
FROM bikes
GROUP BY 1,2
ORDER BY 1,2
),
year_ranked AS 
(SELECT 
* , 
RANK() OVER(PARTITION BY brand ORDER BY revenue_inr DESC) as ranking
FROM Revenue_Brand
)
SELECT * FROM year_ranked WHERE ranking = 1
```

## Findings & Business Recommendations
- **Market Leaders:** Brands like Royal Enfield and Bajaj dominate the market with a high number of models.
- **Customer Preferences:** Most buyers prefer bikes with an engine capacity between 100-250cc due to affordability and fuel efficiency.
- **Premium Segment:** High-end bikes (above 500cc) are priced significantly higher but offer superior power and performance.
- **Best Value:** Some mid-range bikes provide excellent power-to-price ratios, making them ideal choices for performance-focused consumers.

## Future Improvements
- Integrate real-time sales data for deeper insights.
- Perform sentiment analysis on customer reviews to assess brand perception.
- Use visualization tools like Power BI or Tableau for interactive dashboards.

## Conclusion
This project demonstrates the power of SQL in extracting meaningful business insights from raw data. The analysis helps stakeholders understand customer preferences, market trends, and pricing strategies in the Indian motorcycle industry.



