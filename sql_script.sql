USE datawarehouseanalytics;

-- What are the top-selling bike brands and models

SELECT 
brand,
model,
COUNT(*) AS units_sold
FROM bikes
GROUP BY 1,2
ORDER BY 1 , 2 , 3 DESC


-- Brands Average Price INR


SELECT 
brand,
model,
ROUND(AVG(price_inr),2) avg_price
FROM bikes
GROUP BY 1,2
ORDER BY 1,2,3 DESC


-- FUEL TYPE PEOPLE PREFER THE MOST WITH AVG PRICE  


SELECT 
fuel_type,
COUNT(*) count,
ROUND(AVG(price_inr),0) avg_price
FROM bikes 
GROUP BY 1
ORDER BY 2 DESC


-- States With Their Price Segment Preference

SELECT 
state,
CASE
	WHEN price_inr BETWEEN 50000 AND 100000 THEN 'Cheap'
    WHEN price_inr BETWEEN 100000 AND 200000 THEN 'Expensive'
    ELSE 'Premium'
END AS price_category,
COUNT(*) units_sold
FROM bikes
GROUP BY 1,2 
ORDER BY 1 


-- 

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


-- Who is selling bikes and their average selling price

SELECT 
seller_type,
ROUND(AVG(resale_price_inr),0) avg_selling_price
FROM bikes
GROUP BY 1


-- Price Distribution with Insurance Status

SELECT 
insurance_status,
COUNT(*) units,
ROUND(AVG(price_inr),0) avg_price,
ROUND(AVG(resale_price_inr),0) avg_selling_price
FROM bikes
GROUP BY 1


-- States Bike Distibution with Average price and Most Expensive Bike Price

SELECT 
state,
COUNT(*) bikes_sold,
AVG(price_inr) avg_bike_price,
MAX(price_inr) highest_bike_price
FROM bikes
GROUP BY 1
ORDER BY 2 DESC ,4 DESC


-- Engine Preference in CC by States

SELECT 
state,
ROUND(AVG(engine_capacity),0)
FROM bikes
GROUP BY 1 


-- Brand and Models with their Average Mileage and Average Engine Capacity

SELECT
brand,
model,
ROUND(AVG(mileage),0) avg_mileage_kmpl,
ROUND(AVG(engine_capacity),2) avg_engine_capacity_cc,
ROUND(AVG(price_inr),0) avg_price
FROM bikes
GROUP BY 1 ,2


-- How much bike model of each brand travels in each day.

SELECT
brand,
model,
ROUND(AVG(avg_daily_distance),2) daily_distance_km
FROM bikes
GROUP BY 1 ,2
ORDER BY 1


-- Best Performing Year Revenue Wise by each Brand 

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


-- Revenue By Each Brand Year Wise

SELECT 
brand,
registration_year,
COUNT(*) * AVG(price_inr) revenue_inr
FROM bikes
GROUP BY 1,2
ORDER BY 1,2


-- Units Sold by Each Brands each year 

SELECT 
brand,
registration_year,
COUNT(*) units
FROM bikes
GROUP BY 1 ,2 
ORDER BY 1,2 DESC


-- How many new units are sold by each brands 

SELECT 
brand,
COUNT(*) units
FROM bikes
WHERE owner_type = 'First'
GROUP BY 1


-- How many old units are sold by each brands

SELECT 
brand,
COUNT(*) units
FROM bikes
WHERE owner_type <> 'First'
GROUP BY 1

