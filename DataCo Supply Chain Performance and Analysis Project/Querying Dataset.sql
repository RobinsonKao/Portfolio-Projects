## Preliminary Queries to uncover the range of the dataset

# Find the dates the dataset emcompasses. (2015-01-01 - 2018-01-31)
SELECT MIN(Order_Date) AS oldest_order, MAX(Order_Date) AS newest_order
FROM supplychaindata; 

# What are the different payment methods? (Debit, Transfer, Cash, Payment)
SELECT DISTINCT `Type` AS payment_type
FROM supplychaindata;

# List out all distinct delivery statuses. (Advance shipping, Late delivery, Shipping on time, Shipping canceled)
SELECT DISTINCT Delivery_Status
FROM supplychaindata;

# List some example categories for products that are sold.
SELECT DISTINCT Category_Name AS category_names
FROM supplychaindata
ORDER BY category_names ASC
LIMIT 20;

# Count the number of different category names. (50 unique categories)
SELECT COUNT(DISTINCT Category_Name) AS number_of_category_names
FROM supplychaindata;

# Count the number of different cities that have placed orders. (563 cities)
SELECT COUNT(DISTINCT Customer_City) AS number_of_customer_cities
FROM supplychaindata;

# Count the number of different cities where orders have been delivered to. (3594 cities)
SELECT COUNT(DISTINCT Order_City) AS number_of_order_cities
FROM supplychaindata;

# Count the number of different countries where orders have been delivered to. (164 countries)
SELECT COUNT(DISTINCT Order_Country) AS number_of_order_countries
FROM supplychaindata;

# List all different customer segments and how many customers fall into each segment. (Consumer, Home Office, Corporate)
SELECT DISTINCT Customer_Segment AS Customer_Segments, COUNT(Customer_Segment) AS count
FROM supplychaindata
GROUP BY customer_segments;

# List all unique types of department stores that sell the company's products.
SELECT DISTINCT Department_Name AS department_names
FROM supplychaindata;

# List all possible order statuses and how many orders fall under each category.
SELECT DISTINCT Order_Status AS order_statuses, COUNT(*)
FROM supplychaindata
GROUP BY order_statuses
ORDER BY COUNT(*) DESC;

# List all different order regions.
SELECT DISTINCT Order_Region 
FROM supplychaindata;

## Querying Sales Analytics

# 1.) Find the cumulative yearly revenue, cost of goods sold, and net profit generated each year.
WITH RevenueDiscounts AS (
    SELECT 
        Order_Year,
        ROUND(SUM(Sales), 2) AS Sales_Revenue,
        ROUND(SUM(Order_Item_Discount), 2) AS Order_Discount,
        ROUND(SUM(Order_Profit_per_Order), 2) AS Net_Profit
    FROM supplychaindata
    WHERE Order_Status IN ('Complete', 'Closed') -- only include orders that have been completed or closed
    GROUP BY Order_Year
),
CumulativeData AS (
    SELECT
        Order_Year,
        CONCAT('$', Sales_Revenue) AS Sales_Revenue, -- Sales generated in year
        CONCAT('$', ROUND(SUM(Sales_Revenue) OVER (ORDER BY Order_Year ASC), 2)) AS Cumulative_Revenue, -- Cumulative sales generated year-over-year
        CONCAT('$', Order_Discount) AS Order_Discount, -- Total discounts given in year
        CONCAT('$', ROUND(SUM(Order_Discount) OVER (ORDER BY Order_Year ASC), 2)) AS Cumulative_Discounts, -- Cumulative discounts given year-over-year
        ROUND(Sales_Revenue - Order_Discount, 2) AS Net_Sales,  -- Year-by-year Net Sales
        CONCAT('$', ROUND(Net_Profit, 2)) AS Net_Profit -- Year-over-year Net Sales
    FROM RevenueDiscounts
)
SELECT
    Order_Year,
    Sales_Revenue,
    Cumulative_Revenue,
    Order_Discount,
    Cumulative_Discounts,
    CONCAT('$', ROUND(Net_Sales, 2)) AS Net_Sales,  -- Year-by-year Net Sales
    CONCAT('$', ROUND(SUM(Net_Sales) OVER (ORDER BY Order_Year ASC), 2)) AS Cumulative_Net_Sales,  -- Cumulative Net Sales
    Net_Profit
FROM CumulativeData
ORDER BY Order_Year ASC;

# 2.) Find the total revenue generated by each country through the dataset's duration and calculate each country's contribution percentage to total revenue.
SELECT 
Order_Country,
CONCAT('$', ROUND(SUM(Sales), 2)) AS total_revenue,
ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('Complete', 'Closed'))) * 100, 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Country
ORDER BY contribution_percentage DESC;

# 3.) Find the cities with the most sales revenue throughout the dataset's duration and their contrubution percentage to total revenue.
SELECT 
Order_City, 
Order_Country,
CONCAT('$', ROUND(SUM(Sales), 2)) AS total_revenue,
ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('Complete', 'Closed'))) * 100, 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_City, Order_Country
ORDER BY contribution_percentage DESC
LIMIT 30;

# 4.) Find the regions generating the most sales revenue throughout the dataset's duration and their contribution percentage to total revenue.
SELECT Order_Region,
CONCAT('$', ROUND(SUM(Sales), 2)) AS total_revenue,
ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('Complete', 'Closed'))) * 100, 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Region
ORDER BY contribution_percentage DESC;

# 5.) What are the customer demand trends over time?
SELECT 
    Order_Year,
    CONCAT('$', ROUND(SUM(Sales), 2)) AS sales_revenue,
    COUNT(Order_ID) AS Number_of_Orders,
	COUNT(DISTINCT Customer_ID) AS Number_of_Unique_Customers,
	CONCAT('$', ROUND(AVG(Sales), 2)) AS Average_Order_Size,
	SUM(Order_Item_Quantity) AS Total_Quantity_Ordered,
    AVG(Order_Item_Quantity) AS Average_Quantity_Ordered
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Year
ORDER BY Order_Year ASC;

# 6.) What is the average sales value per order by each country?
SELECT Order_Country, COUNT(Order_Date) AS orders_placed, ROUND(AVG(Sales), 2) AS average_order_value, ROUND(AVG(Order_Profit_per_Order), 2) AS average_net_profit_per_order
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Country
ORDER BY orders_placed DESC, average_net_profit_per_order DESC, average_order_value DESC;

## Querying Customer Segmentation

# 7.) What is the relationship between product category and sales performance? Which types of products have the highest product margins?
SELECT Category_Name, ROUND(SUM(Sales), 2) AS sales_revenue, ROUND(AVG(Benefit_per_order), 2) AS average_benefit_per_order, ROUND(SUM(Order_Profit_per_Order), 2) AS total_profit, COUNT(Order_Date) AS orders_placed
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Category_Name
ORDER BY sales_revenue DESC, total_profit DESC, average_benefit_per_order DESC, orders_placed DESC
LIMIT 10;

# 8.) How does benefit per order vary across different categories and customer segments? 
SELECT Category_Name, Customer_Segment, ROUND(AVG(Benefit_per_order), 2) AS average_benefit_per_order, COUNT(Order_Date) AS orders_placed
FROM supplychaindata 
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Category_Name, Customer_Segment
ORDER BY average_benefit_per_order DESC, orders_placed DESC
LIMIT 10;

# 9) Which customer segment represents the largest portion of the company revenue?
SELECT 
Customer_Segment,
CONCAT('$', ROUND(SUM(Sales), 2)) AS sales_revenue,
ROUND(SUM(SALES) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('COMPLETE', 'CLOSED')), 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('COMPLETE', 'CLOSED')
GROUP BY Customer_Segment
ORDER BY contribution_percentage DESC, sales_revenue DESC;

# 10.) What is the rate of return or cancellation across product categories?
SELECT 
    Category_Name,
    COUNT(*) AS number_of_canceled_orders,
    (COUNT(*) / (SELECT COUNT(*) FROM supplychaindata WHERE Order_Status != 'Suspected_Fraud') * 100) AS cancellation_rate # omit fraudulent orders from calculation for accuracy
FROM supplychaindata
WHERE Order_Status = 'CANCELED'
GROUP BY Category_Name
ORDER BY cancellation_rate DESC
LIMIT 10;

# 11.) What is the average profit ratio by category and how does it vary across regions? (most profitable categories by region)
SELECT 
    Category_Name,
    Market,
    average_profit_ratio
FROM (
    SELECT 
        Category_Name,
        Market,
        ROUND(AVG(Order_profit_per_order), 2) AS average_profit_ratio,
        ROW_NUMBER() OVER (PARTITION BY Market ORDER BY ROUND(AVG(Order_profit_per_order), 2) DESC) AS `rank`
    FROM 
        supplychaindata
    WHERE 
        Order_Status IN ('COMPLETE', 'CLOSED')
    GROUP BY 
        Market, Category_Name
) AS RankedProfits
WHERE 
    `rank` <= 5
ORDER BY 
    Market, average_profit_ratio DESC;
    
# 12.) What is the impact of discount rates on sales?  
WITH DiscountImpact AS (
    SELECT
        CASE
            WHEN Order_Item_Discount_Rate IS NULL THEN 'Unknown'
            WHEN Order_Item_Discount_Rate = 0 THEN 'No Discount'
            WHEN Order_Item_Discount_Rate > 0 AND Order_Item_Discount_Rate <= 0.05 THEN 'Low Discount'
            WHEN Order_Item_Discount_Rate > 0.05 AND Order_Item_Discount_Rate <= 0.15 THEN 'Medium Discount'
            WHEN Order_Item_Discount_Rate > 0.15 AND Order_Item_Discount_Rate <= 0.25 THEN 'High Discount'
            ELSE 'Out of Range'
        END AS Discount_Bucket,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(AVG(Order_Item_Discount_Rate), 3) AS Average_Discount
    FROM 
        supplychaindata
    WHERE 
        Order_Status = 'COMPLETE'
    GROUP BY
        Discount_Bucket
)
SELECT
    Discount_Bucket,
    Total_Sales,
    Average_Discount,
    ROUND((Total_Sales / (SELECT SUM(Total_Sales) FROM DiscountImpact)) * 100, 2) AS Sales_Percentage
FROM
    DiscountImpact
ORDER BY
    CASE
        WHEN Discount_Bucket = 'No Discount' THEN 1
        WHEN Discount_Bucket = 'Low Discount' THEN 2
        WHEN Discount_Bucket = 'Medium Discount' THEN 3
        WHEN Discount_Bucket = 'High Discount' THEN 4
        ELSE 5
    END;

# 13.) Which products have the highest discount rates?
SELECT 
    Product_Name, 
    CONCAT(ROUND(AVG(Order_Item_Discount_Rate) * 100, 2), '%') AS average_order_discount
FROM 
    supplychaindata
GROUP BY 
    Product_Name
ORDER BY 
    AVG(Order_Item_Discount_Rate) DESC
LIMIT 15;

# 14.) Create a product summary detailing the best selling products by quantity sold and profit margin.
WITH ProductSummary AS (
    SELECT
        Product_Name,
        Product_Card_ID,
        ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
        SUM(Order_Item_Quantity) AS Total_Quantity_Sold,
        ROUND(SUM(Order_Profit_Per_Order) / NULLIF(SUM(Order_Item_Quantity), 0), 2) AS Average_Profit_Per_Order,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Order_Profit_Per_Order) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin
    FROM
        supplychaindata
    WHERE
        Order_Status IN  ('COMPLETE', 'CLOSED')
    GROUP BY
        Product_Card_ID, Product_Name
),
RankedProducts AS (
    SELECT
        Product_Name,
        Product_Card_ID,
        Total_Profit,
        Total_Quantity_Sold,
        Average_Profit_Per_Order,
        Total_Sales,
        Profit_Margin,
        ROW_NUMBER() OVER (ORDER BY Total_Quantity_Sold DESC, Total_Profit DESC) AS Quantity_Rank,
        ROW_NUMBER() OVER (ORDER BY Profit_Margin DESC, Total_Profit DESC) AS Profit_Margin_Rank
    FROM
        ProductSummary
)
SELECT
    Product_Name,
    Product_Card_ID,
    Total_Profit AS Profit,
    Total_Quantity_Sold AS Quantity_Sold,
    Average_Profit_Per_Order,
    Total_Sales AS Sales,
    Profit_Margin,
    Quantity_Rank,
    Profit_Margin_Rank,
    ROUND((Total_Quantity_Sold / (SELECT SUM(Total_Quantity_Sold) FROM ProductSummary)) * 100, 2) AS Percentage_of_Total_Quantity,
    ROUND((Total_Sales / (SELECT SUM(Total_Sales) FROM ProductSummary)) * 100, 2) AS Percentage_of_Total_Sales
FROM
    RankedProducts
WHERE
    Total_Quantity_Sold >= 10  -- Adjust threshold as needed
ORDER BY
    Percentage_of_Total_Sales DESC -- adjust order of priority to filter for different rankings
LIMIT 15;

## Querying Shipping Efficiency

# 15.) What is the average Shipping time for different methods of transportation?
SELECT Shipping_Mode, Delivery_Status, AVG(Days_for_shipping_real) AS actual_delivery_time, AVG(Days_for_shipment_scheduled) AS scheduled_delivery_time
FROM supplychaindata
GROUP BY Shipping_Mode, Delivery_Status;

# 16.) What percentage of orders arrive by the expected arrival date? (factoring only 'completed' or 'closed' orders)
WITH OrderTimeliness AS (
    SELECT
        COUNT(*) AS Total_Orders,
        COUNT(CASE WHEN Delivery_Status = 'Advance shipping' THEN 1 END) AS Early_Orders,
        COUNT(CASE WHEN Delivery_Status = 'Shipping on time' THEN 1 END) AS On_Time_Orders
    FROM 
        supplychaindata
    WHERE
        Order_Status IN ('Complete', 'Closed')
)
SELECT
    ROUND((Early_Orders * 100.0 / Total_Orders), 2) AS Percentage_Early,
    ROUND((On_Time_Orders * 100.0 / Total_Orders), 2) AS Percentage_On_Time,
    ROUND(100 - ((Early_Orders + On_Time_Orders) * 100.0 / Total_Orders), 2) AS Percentage_Late
FROM
    OrderTimeliness;

# 17.) What percentage of each shipping mode arrives on time or ahead of schedule?
WITH OrderTimeliness AS (
    SELECT
        Shipping_Mode,
        COUNT(*) AS Total_Orders,
        COUNT(CASE WHEN Days_for_shipping_real <= Days_for_shipment_scheduled THEN 1 END) AS On_Time_Orders
    FROM 
        supplychaindata
    WHERE
        Order_Status IN ('COMPLETE', 'CLOSED')
    GROUP BY
        Shipping_Mode
)
SELECT
    Shipping_Mode,
    ROUND((On_Time_Orders * 100.0 / Total_Orders), 2) AS Percentage_On_Time
FROM
    OrderTimeliness
ORDER BY
    Shipping_Mode;
    
# 18.) What is the late delivery risk by region?
WITH DeliveryRisk AS (
    SELECT
        Order_Region,  
        COUNT(*) AS Total_Orders,
        COUNT(CASE WHEN Delivery_Status = 'Late delivery' THEN 1 END) AS Late_Deliveries
    FROM 
        supplychaindata
    WHERE
        Order_Status IN ('COMPLETE', 'CLOSED')
    GROUP BY
        Order_Region
)
SELECT
    Order_Region,
    Total_Orders,
    ROUND((Late_Deliveries * 100.0 / Total_Orders), 2) AS Late_Delivery_Risk_Percentage
FROM
    DeliveryRisk
ORDER BY
    Late_Delivery_Risk_Percentage DESC, Order_Region;
    

# 19.) What is the late delivery risk by country?
WITH DeliveryRisk AS (
    SELECT
        Order_Country, 
        COUNT(*) AS Total_Orders,
        COUNT(CASE WHEN Delivery_Status = 'Late delivery' THEN 1 END) AS Late_Deliveries
    FROM 
        supplychaindata
    WHERE
        Order_Status IN ('COMPLETE', 'CLOSED')
    GROUP BY
        Order_Country
)
SELECT
    Order_Country,
    Total_Orders,
    ROUND((Late_Deliveries * 100.0 / Total_Orders), 2) AS Late_Delivery_Risk_Percentage
FROM
    DeliveryRisk
WHERE 
	Total_Orders >= 10 -- only include countries that have at least 10 orders on record (for statistical significance)
ORDER BY
    Late_Delivery_Risk_Percentage DESC;
    
# 20.) How is the customer retention rate of each customer segment?
WITH CustomerYearlyData AS (
    SELECT
        Customer_ID,  -- Replace with your actual column name for customer ID
        EXTRACT(YEAR FROM Order_Date) AS Order_Year,
        Customer_Segment  -- Replace with your actual column name for customer segment
    FROM 
        supplychaindata
    WHERE
        Order_Status = 'COMPLETE'
    GROUP BY
        Customer_ID, EXTRACT(YEAR FROM Order_Date), Customer_Segment
),
RetainedCustomers AS (
    SELECT
        CYD1.Order_Year AS Current_Year,
        CYD1.Customer_Segment,
        COUNT(DISTINCT CYD1.Customer_ID) AS Total_Customers_Current_Year,
        COUNT(DISTINCT CASE WHEN CYD2.Customer_ID IS NOT NULL THEN CYD1.Customer_ID END) AS Retained_Customers,
        COUNT(DISTINCT CASE WHEN CYD2.Customer_ID IS NULL THEN CYD1.Customer_ID END) AS New_Customers
    FROM
        CustomerYearlyData CYD1
    LEFT JOIN
        CustomerYearlyData CYD2 ON CYD1.Customer_ID = CYD2.Customer_ID
        AND CYD2.Order_Year = CYD1.Order_Year - 1
        AND CYD1.Customer_Segment = CYD2.Customer_Segment
    GROUP BY
        CYD1.Order_Year, CYD1.Customer_Segment
    HAVING
        CYD1.Order_Year > (SELECT MIN(Order_Year) FROM CustomerYearlyData)  -- Exclude the first year since there's no previous year to compare
)
SELECT
    Current_Year,
    Customer_Segment,
    Total_Customers_Current_Year,
    Retained_Customers,
    ROUND((Retained_Customers * 100.0 / Total_Customers_Current_Year), 2) AS Retention_Rate,
    New_Customers
FROM
    RetainedCustomers
ORDER BY
    Current_Year, Customer_Segment;
    
# 21.) What is the overall customer retention rate?
WITH CustomerYearlyData AS (
    SELECT
        Customer_ID,  -- Replace with your actual column name for customer ID
        EXTRACT(YEAR FROM Order_Date) AS Order_Year
    FROM 
        supplychaindata
    WHERE
        Order_Status = 'COMPLETE'
    GROUP BY
        Customer_ID, EXTRACT(YEAR FROM Order_Date)
),
RetainedCustomers AS (
    SELECT
        CYD1.Order_Year AS Current_Year,
        COUNT(DISTINCT CYD1.Customer_ID) AS Total_Customers_Current_Year,
        COUNT(DISTINCT CASE WHEN CYD2.Customer_ID IS NOT NULL THEN CYD1.Customer_ID END) AS Retained_Customers,
        COUNT(DISTINCT CYD1.Customer_ID) - COUNT(DISTINCT CASE WHEN CYD2.Customer_ID IS NOT NULL THEN CYD1.Customer_ID END) AS New_Customers
    FROM
        CustomerYearlyData CYD1
    LEFT JOIN
        CustomerYearlyData CYD2 ON CYD1.Customer_ID = CYD2.Customer_ID
        AND CYD2.Order_Year = CYD1.Order_Year - 1
    GROUP BY
        CYD1.Order_Year
    HAVING
        CYD1.Order_Year > (SELECT MIN(Order_Year) FROM CustomerYearlyData)  -- Exclude the first year since there's no previous year to compare
)
SELECT
    Current_Year,
    Total_Customers_Current_Year,
    Retained_Customers,
    New_Customers,
    ROUND((Retained_Customers * 100.0 / Total_Customers_Current_Year), 2) AS Retention_Rate
FROM
    RetainedCustomers
ORDER BY
    Current_Year;