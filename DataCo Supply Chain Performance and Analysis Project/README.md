# 🚚 DataCo Supply Chain Performance and Analysis Project

## Objective

In this project, I utilized a comprehensive supply chain dataset from Kaggle for DataCo Global. After importing the data into MySQL and carefully assigning appropriate data types, I conducted data transformation, wrangling, and exploratory data analysis. The findings were then presented through an interactive dashboard, showcasing key insights into revenue generation, geographical sales patterns, customer segmentation, and shipping performance.

1. Sourced a comprehensive supply chain dataset from Kaggle and imported it into MySQL for structured analysis.
2. Assigned appropriate data types, removed unnecessary columns, and created new columns.
3. Executed data transformation and advanced SQL queries in MySQL to derive meaningful insights.
4. Exported query results to Excel for additional processing and subsequently uploaded the data to Tableau for visualization.
5. Designed and developed an interactive dashboard in Tableau to present the key findings.

Given this project is centered around MySQL, the primary emphasis is on query execution, which will be showcased below.

The following sections provide further details on the technologies used and the files involved.

## Table of Content

- [Dataset Used](#dataset-used)
- [Technologies](#technologies)
- [Step 1: Importing the Data](#step-1-importing-dataset-into-mysql)
- [Step 2: Data Preprocessing](#step-2-data-transformation-and-preprocessing)
- [Step 3: Querying & Analytics](#step-3-querying-&-analytics)
- [Step 4: Dashboard Development](#step-4-tableau-dashboard-development)

## Dataset Used

The dataset pertains to DataCo Global, a company engaged in global supply chain operations. It encompasses detailed transactional data, including sales, customer information, product details, and shipping logistics over the timespan from the beginning of 2015 through January of 2018. The dataset is designed to provide insights into revenue generation, geographical sales patterns, customer segmentation, and shipping efficiency across various regions. The raw dataset contains a myriad of categorical and numerical columns.

#### Detailed Column Descriptions

1.) Type: Type of transaction made (Debit, Transfer, Cash, Payment).

2.) Days for Shipping (real): Actual number of days taken to ship the purchased product.

3.) Days for Shipment (scheduled): Number of days scheduled for the delivery of the purchased product.

4.) Benefit per Order: Earnings per order placed.

5.) Sales per Customer: Total sales made to each customer.

6.) Delivery Status: Status of orders (e.g., advance shipping, late delivery, shipping canceled, on-time shipping).

7.) Late Delivery Risk: Categorical variable indicating late delivery risk (1 for late, 0 for on-time).

8.) Category Id: Unique identifier for the product category.

9.) Category Name: Description of the product category.

10.) Customer City: City where the customer made the purchase.

11.) Customer Country: Country where the customer made the purchase.

12.) Customer Email: Email address of the customer.

13.) Customer Fname: First name of the customer.

14.) Customer Id: Unique identifier for the customer.

15.) Customer Lname: Last name of the customer.

16.) Customer Password: Masked password for the customer account.

17.) Customer Segment: Customer classification (e.g., Consumer, Corporate, Home Office).

18.) Customer State: State where the store where the purchase was registered is located.

19.) Customer Street: Street address associated with the customer.

20.) Customer Zipcode: Zipcode of the customer's location.

21.) Department Id: Unique identifier for the department in the store.

22.) Department Name: Name of the department in the store.

23.) Latitude: Latitude coordinate of the store's location.

24.) Longitude: Longitude coordinate of the store's location.

25.) Market: Market where the order is delivered (e.g., Africa, Europe, LATAM, Pacific Asia, USCA).

26.) Order City: Destination city of the order.

27.) Order Country: Destination country of the order.

28.) Order Customer Id: Unique identifier for the customer order.

29.) Order Date (DateOrders): Date on which the order was placed.

30.) Order Id: Unique identifier for the order.

31.) Order Item Cardprod Id: Unique product code generated through an RFID reader.

32.) Order Item Discount: Discount amount applied to the order item.

33.) Order Item Discount Rate: Percentage discount applied to the order item.

34.) Order Item Id: Unique identifier for the order item.

35.) Order Item Product Price: Price of the product before any discount.

36.) Order Item Profit Ratio: Profit margin of the order item.

37.) Order Item Quantity: Number of products included in the order.

38.) Sales: Sales value of the order.

39.) Order Item Total: Total amount per order item.

40.) Order Profit Per Order: Profit generated per order.

41.) Order Region: Geographic region where the order is delivered (e.g., Southeast Asia, South Asia, Oceania).

42.) Order State: State of the region where the order is delivered.

43.) Order Status: Status of the order (e.g., COMPLETE, PENDING, CLOSED, CANCELED).

44.) Product Card Id: Unique product identifier.

45.) Product Category Id: Unique identifier for the product category.

46.) Product Description: Description of the product.

47.) Product Image: URL link to the product image.

48.) Product Name: Name of the product.

49.) Product Price: Price of the product.

50.) Product Status: Availability status of the product (1 for not available, 0 for available).

51.) Shipping Date (DateOrders): Exact date and time when the order was shipped.

52.) Shipping Mode: Shipping method used (e.g., Standard Class, First Class, Second Class, Same Day).

More info about the dataset can be found in the following link:

- Website: [DataCo Supply Chain Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis/data?select=tokenized_access_logs.csv)

## Technologies

The following technologies were used to build this project:

- Language: SQL
- Extraction, Transformation, EDA: MySQL, Excel
- Dashboard Development: Tableau

## Step 1: Importing Dataset into MySQL 

In this step, I created a new database called "supply_chain_big_data" and set up two tables: "TempSupplyChainData," a temporary table for importing all columns of the CSV as varchars to prevent datatype conflicts, and "SupplyChainData," which is designed to store the "TempSupplyChainData" CSV data with the appropriate datatypes.

#### Create New Database

```sql
CREATE DATABASE supply_chain_big_data;
```

#### Create Dummy Table to Import CSV and avoid Datatype Conflicts

```sql
CREATE TABLE TempSupplyChainData (
    Type VARCHAR(50),
    Days_for_shipping_real VARCHAR(10),
    Days_for_shipment_scheduled VARCHAR(10),
    Benefit_per_order VARCHAR(20),
    Sales_per_customer VARCHAR(20),
    Delivery_Status VARCHAR(50),
    Late_delivery_risk VARCHAR(10),
    Category_Id VARCHAR(10),
    Category_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Customer_Country VARCHAR(100),
    Customer_Email VARCHAR(100),
    Customer_Fname VARCHAR(50),
    Customer_Id VARCHAR(10),
    Customer_Lname VARCHAR(50),
    Customer_Password VARCHAR(100),
    Customer_Segment VARCHAR(50),
    Customer_State VARCHAR(50),
    Customer_Street VARCHAR(100),
    Customer_Zipcode VARCHAR(20),
    Department_Id VARCHAR(10),
    Department_Name VARCHAR(100),
    Latitude VARCHAR(20),
    Longitude VARCHAR(20),
    Market VARCHAR(50),
    Order_City VARCHAR(100),
    Order_Country VARCHAR(100),
    Order_Customer_Id VARCHAR(10),
    Order_Date VARCHAR(20),
    Order_Id VARCHAR(10),
    Order_Item_Cardprod_Id VARCHAR(10),
    Order_Item_Discount VARCHAR(20),
    Order_Item_Discount_Rate VARCHAR(20),
    Order_Item_Id VARCHAR(10),
    Order_Item_Product_Price VARCHAR(20),
    Order_Item_Profit_Ratio VARCHAR(20),
    Order_Item_Quantity VARCHAR(10),
    Sales VARCHAR(20),
    Order_Item_Total VARCHAR(20),
    Order_Profit_Per_Order VARCHAR(20),
    Order_Region VARCHAR(50),
    Order_State VARCHAR(50),
    Order_Status VARCHAR(50),
    Order_Zipcode VARCHAR(20),
    Product_Card_Id VARCHAR(10),
    Product_Category_Id VARCHAR(10),
    Product_Description TEXT,
    Product_Image VARCHAR(255),
    Product_Name VARCHAR(100),
    Product_Price VARCHAR(20),
    Product_Status VARCHAR(10),
    Shipping_Date VARCHAR(20),
    Shipping_Mode VARCHAR(50)
) CHARACTER SET utf8mb4;
```

#### Load the CSV Data into the TempTable with Temporary Datatypes (VarChar).

```sql
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DataCoSupplyChainDataset.csv'
INTO TABLE TempSupplyChainData
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
```

#### Create the Actual Table and Assign each Column's Datatype Manually.

```sql
CREATE TABLE SupplyChainData (
    Type VARCHAR(50),
    Days_for_shipping_real INT,
    Days_for_shipment_scheduled INT,
    Benefit_per_order FLOAT,
    Sales_per_customer FLOAT,
    Delivery_Status VARCHAR(50),
    Late_delivery_risk INT,
    Category_Id INT,
    Category_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Customer_Country VARCHAR(100),
    Customer_Email VARCHAR(100),
    Customer_Fname VARCHAR(50),
    Customer_Id INT,
    Customer_Lname VARCHAR(50),
    Customer_Password VARCHAR(100),
    Customer_Segment VARCHAR(50),
    Customer_State VARCHAR(50),
    Customer_Street VARCHAR(100),
    Customer_Zipcode VARCHAR(20),
    Department_Id INT,
    Department_Name VARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT,
    Market VARCHAR(50),
    Order_City VARCHAR(100),
    Order_Country VARCHAR(100),
    Order_Customer_Id INT,
    Order_Date DATETIME,
    Order_Id INT,
    Order_Item_Cardprod_Id INT,
    Order_Item_Discount FLOAT,
    Order_Item_Discount_Rate FLOAT,
    Order_Item_Id INT,
    Order_Item_Product_Price FLOAT,
    Order_Item_Profit_Ratio FLOAT,
    Order_Item_Quantity INT,
    Sales FLOAT,
    Order_Item_Total FLOAT,
    Order_Profit_Per_Order FLOAT,
    Order_Region VARCHAR(50),
    Order_State VARCHAR(50),
    Order_Status VARCHAR(50),
    Order_Zipcode VARCHAR(20),
    Product_Card_Id INT,
    Product_Category_Id INT,
    Product_Description TEXT,
    Product_Image VARCHAR(255),
    Product_Name VARCHAR(100),
    Product_Price FLOAT,
    Product_Status INT,
    Shipping_Date DATETIME,
    Shipping_Mode VARCHAR(50)
);
```

#### Insert Formatted / Correctly Typed Data Into the Actual Table.

```sql
INSERT INTO SupplyChainData (
    Type,
    Days_for_shipping_real,
    Days_for_shipment_scheduled,
    Benefit_per_order,
    Sales_per_customer,
    Delivery_Status,
    Late_delivery_risk,
    Category_Id,
    Category_Name,
    Customer_City,
    Customer_Country,
    Customer_Email,
    Customer_Fname,
    Customer_Id,
    Customer_Lname,
    Customer_Password,
    Customer_Segment,
    Customer_State,
    Customer_Street,
    Customer_Zipcode,
    Department_Id,
    Department_Name,
    Latitude,
    Longitude,
    Market,
    Order_City,
    Order_Country,
    Order_Customer_Id,
    Order_Date,
    Order_Id,
    Order_Item_Cardprod_Id,
    Order_Item_Discount,
    Order_Item_Discount_Rate,
    Order_Item_Id,
    Order_Item_Product_Price,
    Order_Item_Profit_Ratio,
    Order_Item_Quantity,
    Sales,
    Order_Item_Total,
    Order_Profit_Per_Order,
    Order_Region,
    Order_State,
    Order_Status,
    Order_Zipcode,
    Product_Card_Id,
    Product_Category_Id,
    Product_Description,
    Product_Image,
    Product_Name,
    Product_Price,
    Product_Status,
    Shipping_Date,
    Shipping_Mode
)
SELECT 
    Type,
    CAST(Days_for_shipping_real AS DOUBLE),
    CAST(Days_for_shipment_scheduled AS DOUBLE),
    CAST(Benefit_per_order AS FLOAT),
    CAST(Sales_per_customer AS FLOAT),
    Delivery_Status,
    CAST(Late_delivery_risk AS DOUBLE),
    CAST(Category_Id AS DOUBLE),
    Category_Name,
    Customer_City,
    Customer_Country,
    Customer_Email,
    Customer_Fname,
    CAST(Customer_Id AS DOUBLE),
    Customer_Lname,
    Customer_Password,
    Customer_Segment,
    Customer_State,
    Customer_Street,
    Customer_Zipcode,
    CAST(Department_Id AS DOUBLE),
    Department_Name,
    CAST(Latitude AS FLOAT),
    CAST(Longitude AS FLOAT),
    Market,
    Order_City,
    Order_Country,
    CAST(Order_Customer_Id AS DOUBLE),
    STR_TO_DATE(Order_Date, '%m/%d/%Y %H:%i') AS Order_Date,
    CAST(Order_Id AS DOUBLE),
    CAST(Order_Item_Cardprod_Id AS DOUBLE),
    CAST(Order_Item_Discount AS FLOAT),
    CAST(Order_Item_Discount_Rate AS FLOAT),
    CAST(Order_Item_Id AS DOUBLE),
    CAST(Order_Item_Product_Price AS FLOAT),
    CAST(Order_Item_Profit_Ratio AS FLOAT),
    CAST(Order_Item_Quantity AS DOUBLE),
    CAST(Sales AS FLOAT),
    CAST(Order_Item_Total AS FLOAT),
    CAST(Order_Profit_Per_Order AS FLOAT),
    Order_Region,
    Order_State,
    Order_Status,
    Order_Zipcode,
    CAST(Product_Card_Id AS DOUBLE),
    CAST(Product_Category_Id AS DOUBLE),
    Product_Description,
    Product_Image,
    Product_Name,
    CAST(Product_Price AS FLOAT),
    CAST(Product_Status AS DOUBLE),
    STR_TO_DATE(Shipping_Date, '%m/%d/%Y %H:%i') AS Shipping_Date,
    Shipping_Mode
FROM TempSupplyChainData;
```


## Step 2: Data Transformation and Preprocessing

#### Dropping Non-essential Columns from Dataset.

```sql
ALTER TABLE supplychaindata
DROP COLUMN Customer_Email,
DROP COLUMN Customer_Password,
DROP COLUMN Product_Description,
DROP COLUMN Product_Image;
```

#### Translate 'Order_Country' names from Spanish to English for Legibility.

```sql
UPDATE supplychaindata
SET Order_Country = CASE Order_Country
    WHEN 'Japón' THEN 'Japan'
    WHEN 'Corea del Sur' THEN 'South Korea'
    WHEN 'Singapur' THEN 'Singapore'
    WHEN 'Turquía' THEN 'Turkey'
    WHEN 'Mongolia' THEN 'Mongolia'
    WHEN 'Estados Unidos' THEN 'United States'
    WHEN 'Nigeria' THEN 'Nigeria'
    WHEN 'República Democrática del Congo' THEN 'Democratic Republic of the Congo'
    WHEN 'Senegal' THEN 'Senegal'
    WHEN 'Marruecos' THEN 'Morocco'
    WHEN 'Alemania' THEN 'Germany'
    WHEN 'Francia' THEN 'France'
    WHEN 'Países Bajos' THEN 'Netherlands'
    WHEN 'Reino Unido' THEN 'United Kingdom'
    WHEN 'Guatemala' THEN 'Guatemala'
    WHEN 'El Salvador' THEN 'El Salvador'
    WHEN 'Panamá' THEN 'Panama'
    WHEN 'República Dominicana' THEN 'Dominican Republic'
    WHEN 'Venezuela' THEN 'Venezuela'
    WHEN 'Colombia' THEN 'Colombia'
    WHEN 'Honduras' THEN 'Honduras'
    WHEN 'Brasil' THEN 'Brazil'
    WHEN 'México' THEN 'Mexico'
    WHEN 'Uruguay' THEN 'Uruguay'
    WHEN 'Argentina' THEN 'Argentina'
    WHEN 'Cuba' THEN 'Cuba'
    WHEN 'Perú' THEN 'Peru'
    WHEN 'Nicaragua' THEN 'Nicaragua'
    WHEN 'Ecuador' THEN 'Ecuador'
    WHEN 'Angola' THEN 'Angola'
    WHEN 'Sudán' THEN 'Sudan'
    WHEN 'Somalia' THEN 'Somalia'
    WHEN 'Costa de Marfil' THEN 'Ivory Coast'
    WHEN 'Egipto' THEN 'Egypt'
    WHEN 'Italia' THEN 'Italy'
    WHEN 'España' THEN 'Spain'
    WHEN 'Suecia' THEN 'Sweden'
    WHEN 'Austria' THEN 'Austria'
    WHEN 'Canada' THEN 'Canada'
    WHEN 'Madagascar' THEN 'Madagascar'
    WHEN 'Argelia' THEN 'Algeria'
    WHEN 'Liberia' THEN 'Liberia'
    WHEN 'Zambia' THEN 'Zambia'
    WHEN 'Níger' THEN 'Niger'
    WHEN 'Sudáfrica' THEN 'South Africa'
    WHEN 'Mozambique' THEN 'Mozambique'
    WHEN 'Tanzania' THEN 'Tanzania'
    WHEN 'Ruanda' THEN 'Rwanda'
    WHEN 'Israel' THEN 'Israel'
    WHEN 'Nueva Zelanda' THEN 'New Zealand'
    WHEN 'Bangladés' THEN 'Bangladesh'
    WHEN 'Tailandia' THEN 'Thailand'
    WHEN 'Irak' THEN 'Iraq'
    WHEN 'Arabia Saudí' THEN 'Saudi Arabia'
    WHEN 'Filipinas' THEN 'Philippines'
    WHEN 'Kazajistán' THEN 'Kazakhstan'
    WHEN 'Irán' THEN 'Iran'
    WHEN 'Myanmar (Birmania)' THEN 'Myanmar (Burma)'
    WHEN 'Uzbekistán' THEN 'Uzbekistan'
    WHEN 'Benín' THEN 'Benin'
    WHEN 'Camerún' THEN 'Cameroon'
    WHEN 'Kenia' THEN 'Kenya'
    WHEN 'Togo' THEN 'Togo'
    WHEN 'Ucrania' THEN 'Ukraine'
    WHEN 'Polonia' THEN 'Poland'
    WHEN 'Portugal' THEN 'Portugal'
    WHEN 'Rumania' THEN 'Romania'
    WHEN 'Trinidad y Tobago' THEN 'Trinidad and Tobago'
    WHEN 'Afganistán' THEN 'Afghanistan'
    WHEN 'Pakistán' THEN 'Pakistan'
    WHEN 'Vietnam' THEN 'Vietnam'
    WHEN 'Malasia' THEN 'Malaysia'
    WHEN 'Finlandia' THEN 'Finland'
    WHEN 'Rusia' THEN 'Russia'
    WHEN 'Irlanda' THEN 'Ireland'
    WHEN 'Noruega' THEN 'Norway'
    WHEN 'Eslovaquia' THEN 'Slovakia'
    WHEN 'Bélgica' THEN 'Belgium'
    WHEN 'Bolivia' THEN 'Bolivia'
    WHEN 'Chile' THEN 'Chile'
    WHEN 'Jamaica' THEN 'Jamaica'
    WHEN 'Yemen' THEN 'Yemen'
    WHEN 'Ghana' THEN 'Ghana'
    WHEN 'Guinea' THEN 'Guinea'
    WHEN 'Etiopía' THEN 'Ethiopia'
    WHEN 'Bulgaria' THEN 'Bulgaria'
    WHEN 'Kirguistán' THEN 'Kyrgyzstan'
    WHEN 'Georgia' THEN 'Georgia'
    WHEN 'Nepal' THEN 'Nepal'
    WHEN 'Emiratos Árabes Unidos' THEN 'United Arab Emirates'
    WHEN 'Camboya' THEN 'Cambodia'
    WHEN 'Uganda' THEN 'Uganda'
    WHEN 'Lesoto' THEN 'Lesotho'
    WHEN 'Lituania' THEN 'Lithuania'
    WHEN 'Suiza' THEN 'Switzerland'
    WHEN 'Hungría' THEN 'Hungary'
    WHEN 'Dinamarca' THEN 'Denmark'
    WHEN 'Haití' THEN 'Haiti'
    WHEN 'Bielorrusia' THEN 'Belarus'
    WHEN 'Croacia' THEN 'Croatia'
    WHEN 'Laos' THEN 'Laos'
    WHEN 'Baréin' THEN 'Bahrain'
    WHEN 'Macedonia' THEN 'North Macedonia'
    WHEN 'República Checa' THEN 'Czech Republic'
    WHEN 'Sri Lanka' THEN 'Sri Lanka'
    WHEN 'Zimbabue' THEN 'Zimbabwe'
    WHEN 'Eritrea' THEN 'Eritrea'
    WHEN 'Burkina Faso' THEN 'Burkina Faso'
    WHEN 'Costa Rica' THEN 'Costa Rica'
    WHEN 'Libia' THEN 'Libya'
    WHEN 'Barbados' THEN 'Barbados'
    WHEN 'Tayikistán' THEN 'Tajikistan'
    WHEN 'Siria' THEN 'Syria'
    WHEN 'Guadalupe' THEN 'Guadeloupe'
    WHEN 'Papúa Nueva Guinea' THEN 'Papua New Guinea'
    WHEN 'Azerbaiyán' THEN 'Azerbaijan'
    WHEN 'Turkmenistán' THEN 'Turkmenistan'
    WHEN 'Paraguay' THEN 'Paraguay'
    WHEN 'Jordania' THEN 'Jordan'
    WHEN 'Hong Kong' THEN 'Hong Kong'
    WHEN 'Martinica' THEN 'Martinique'
    WHEN 'Moldavia' THEN 'Moldova'
    WHEN 'Qatar' THEN 'Qatar'
    WHEN 'Mali' THEN 'Mali'
    WHEN 'Albania' THEN 'Albania'
    WHEN 'República del Congo' THEN 'Republic of the Congo'
    WHEN 'Bosnia y Herzegovina' THEN 'Bosnia and Herzegovina'
    WHEN 'Omán' THEN 'Oman'
    WHEN 'Túnez' THEN 'Tunisia'
    WHEN 'Sierra Leona' THEN 'Sierra Leone'
    WHEN 'Yibuti' THEN 'Djibouti'
    WHEN 'Burundi' THEN 'Burundi'
    WHEN 'Montenegro' THEN 'Montenegro'
    WHEN 'Gabón' THEN 'Gabon'
    WHEN 'Sudán del Sur' THEN 'South Sudan'
    WHEN 'Luxemburgo' THEN 'Luxembourg'
    WHEN 'Namibia' THEN 'Namibia'
    WHEN 'Mauritania' THEN 'Mauritania'
    WHEN 'Grecia' THEN 'Greece'
    WHEN 'Suazilandia' THEN 'Eswatini'
    WHEN 'Guyana' THEN 'Guyana'
    WHEN 'Guyana Francesa' THEN 'French Guiana'
    WHEN 'República Centroafricana' THEN 'Central African Republic'
    WHEN 'Taiwán' THEN 'Taiwan'
    WHEN 'Estonia' THEN 'Estonia'
    WHEN 'Líbano' THEN 'Lebanon'
    WHEN 'Chipre' THEN 'Cyprus'
    WHEN 'Guinea-Bissau' THEN 'Guinea-Bissau'
    WHEN 'Surinam' THEN 'Suriname'
    WHEN 'Belice' THEN 'Belize'
    WHEN 'Eslovenia' THEN 'Slovenia'
    WHEN 'República de Gambia' THEN 'Gambia'
    WHEN 'Botsuana' THEN 'Botswana'
    WHEN 'Armenia' THEN 'Armenia'
    WHEN 'Guinea Ecuatorial' THEN 'Equatorial Guinea'
    WHEN 'Kuwait' THEN 'Kuwait'
    WHEN 'Bután' THEN 'Bhutan'
    WHEN 'Chad' THEN 'Chad'
    WHEN 'Serbia' THEN 'Serbia'
    WHEN 'Sáhara Occidental' THEN 'Western Sahara'
    ELSE Order_Country
END;
```

#### Create New Column "Year" by Extracting it from 'Order_Date' Column. This column will be useful for aggregating different metrics yearly to uncover year-to-year trends.

```sql
ALTER TABLE supplychaindata ADD COLUMN Order_Year INT;
UPDATE supplychaindata 
SET Order_Year= YEAR(Order_Date);
```

#### Extract "Month" from 'Order_Date' into new column. This column will be useful for aggregating different metrics on a month-to-month basis.

```sql
ALTER TABLE supplychaindata ADD COLUMN Order_Month INT;
UPDATE supplychaindata
SET Order_Month = MONTH(Order_Date);
```

#### View example rows of the remaining columns.

```sql
SELECT *
FROM supplychaindata
LIMIT 5;
```
| Type   | Days for shipping (real) | Days for shipment (scheduled) | Benefit per order | Sales per customer | Delivery Status   | Late_delivery_risk | Category Id | Category Name  | Customer City | Customer Country | Customer Fname | Customer Id | Customer Lname | Customer Segment | Customer State | Customer Street              | Customer Zipcode | Department Id | Department Name | Latitude | Longitude | Market        | Order City | Order Country | Order Customer Id | Order date (DateOrders) | Order Id | Order Item Cardprod Id | Order Item Discount | Order Item Discount Rate | Order Item Id | Order Item Product Price | Order Item Profit Ratio | Order Item Quantity | Sales  | Order Item Total | Order Profit Per Order | Order Region   | Order State    | Order Status    | Order_Zipcode | Product Card Id | Product Category Id | Product Name | Product Price | Product Status | Shipping date (DateOrders) | Shipping Mode  | Order_Year | Order_Month |
|--------|--------------------------|-------------------------------|-------------------|--------------------|--------------------|--------------------|-------------|----------------|---------------|------------------|----------------|-------------|----------------|------------------|----------------|----------------------------|------------------|---------------|----------------|----------|-----------|---------------|------------|---------------|-------------------|-------------------------|----------|------------------------|---------------------|-------------------------|---------------|--------------------------|------------------------|----------------------|--------|------------------|------------------------|----------------|----------------|-----------------|----------------|----------------|--------------------|--------------|---------------|----------------|---------------------------|----------------|------------|-------------|
| DEBIT  | 3                        | 4                             | 91.25             | 314.64             | Advance shipping   | 0                  | 73          | Sporting Goods | Caguas        | Puerto Rico      | Cally          | 20755       | Holloway       | Consumer         | PR             | 5365 Noble Nectar Island   | 725              | 2             | Fitness        | 18.2515  | -66.0371  | Pacific Asia  | Bekasi     | Indonesia     | 20755             | 1/31/2018 22:56        | 77202    | 1360                   | 13.11               | 0.04                    | 180517        | 327.75                  | 0.29                   | 1                    | 327.75 | 327.75           | 314.64                 | Southeast Asia | Java Occidental | COMPLETE        |                | 1360           | 73                 | Smart watch  | 327.75        | 0              | 2/3/2018 22:56            | Standard Class | 2018       | 1           |
| TRANSFER | 5                      | 4                             | -249.09           | 311.36             | Late delivery      | 1                  | 73          | Sporting Goods | Caguas        | Puerto Rico      | Irene          | 19492       | Luna          | Consumer         | PR             | 2679 Rustic Loop           | 725              | 2             | Fitness        | 18.2795  | -66.0371  | Pacific Asia  | Bikaner    | India         | 19492             | 1/13/2018 12:27        | 75939    | 1360                   | 16.39               | 0.05                    | 179254        | 327.75                  | -0.8                   | 1                    | 327.75 | 327.75           | 311.36                 | South Asia     | Rajastán       | PENDING         |                | 1360           | 73                 | Smart watch  | 327.75        | 0              | 1/18/2018 12:27            | Standard Class | 2018       | 1           |
| CASH   | 4                        | 4                             | -247.78           | 309.72             | Shipping on time   | 0                  | 73          | Sporting Goods | San Jose      | EE. UU.          | Gillian        | 19491       | Maldonado      | Consumer         | CA             | 8510 Round Bear Gate      | 95125            | 2             | Fitness        | 37.2922  | -121.881  | Pacific Asia  | Bikaner    | India         | 19491             | 1/13/2018 12:06        | 75938    | 1360                   | 18.03               | 0.06                    | 179253        | 327.75                  | -0.8                   | 1                    | 327.75 | 327.75           | 309.72                 | South Asia     | Rajastán       | CLOSED          |                | 1360           | 73                 | Smart watch  | 327.75        | 0              | 1/17/2018 12:06            | Standard Class | 2018       | 1           |
| DEBIT  | 3                        | 4                             | 22.86             | 304.81             | Advance shipping   | 0                  | 73          | Sporting Goods | Los Angeles   | EE. UU.          | Tana           | 19490       | Tate          | Home Office      | CA             | 3200 Amber Bend            | 90027            | 2             | Fitness        | 34.1259  | -118.291  | Pacific Asia  | Townsville | Australia     | 19490             | 1/13/2018 11:45        | 75937    | 1360                   | 22.94               | 0.07                    | 179252        | 327.75                  | 0.08                   | 1                    | 327.75 | 327.75           | 304.81                 | Oceania        | Queensland     | COMPLETE        |                | 1360           | 73                 | Smart watch  | 327.75        | 0              | 1/16/2018 11:45            | Standard Class | 2018       | 1           |
| PAYMENT | 2                       | 4                             | 134.21            | 298.25             | Advance shipping   | 0                  | 73          | Sporting Goods | Caguas        | Puerto Rico      | Orli           | 19489       | Hendricks     | Corporate        | PR             | 8671 Iron Anchor Corners  | 725              | 2             | Fitness        | 18.2538  | -66.037   | Pacific Asia  | Townsville | Australia     | 19489             | 1/13/2018 11:24        | 75936    | 1360                   | 29.5                | 0.09                    | 179251        | 327.75                  | 0.45                   | 1                    | 327.75 | 327.75           | 298.25                 | Oceania        | Queensland     | PENDING_PAYMENT |                | 1360           | 73                 | Smart watch  | 327.75        | 0              | 1/15/2018 11:24            | Standard Class | 2018       | 1           |


## Step 3: Querying & Analytics

### Querying Sales Analytics:

####  1.) Find the cumulative yearly revenue, cost of goods sold, and net profit generated each year.

```sql
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
```

| Order Year | Sales Revenue   | Cumulative Revenue | Order Discount | Cumulative Discounts | Net Sales      | Cumulative Net Sales | Net Profit |
|------------|-----------------|--------------------|----------------|-----------------------|----------------|----------------------|------------|
| 2015       | $5,407,673.60   | $5,407,673.60      | $549,943.84    | $549,943.84           | $4,857,729.76  | $4,857,729.76        | $598,027.68 |
| 2016       | $5,427,860.53   | $10,835,534.13     | $554,196.70    | $1,104,140.54         | $4,873,663.83  | $9,731,393.59        | $571,882.70 |
| 2017       | $5,132,901.25   | $15,968,435.38     | $521,939.78    | $1,626,080.32         | $4,610,961.47  | $14,342,355.06       | $591,282.04 |
| 2018       | $149,503.74     | $16,117,939.12     | $15,140.01     | $1,641,220.33         | $134,363.73    | $14,476,718.79       | $18,524.42  |


#### 2.) Find the total revenue generated by each country through the dataset's duration and calculate each country's contribution percentage to total revenue.

```sql
SELECT 
Order_Country,
CONCAT('$', ROUND(SUM(Sales), 2)) AS total_revenue,
ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('Complete', 'Closed'))) * 100, 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Country
ORDER BY contribution_percentage DESC;
```

| Order Country                         | Total Revenue   | Contribution Percentage |
|--------------------------------------|-----------------|--------------------------|
| United States                        | $2,181,086.96   | 13.53                    |
| France                               | $1,281,079.51   | 7.95                     |
| Mexico                               | $1,169,953.26   | 7.26                     |
| Germany                              | $898,156.12     | 5.57                     |
| Australia                            | $752,830.37     | 4.67                     |
| United Kingdom                       | $711,666.95     | 4.42                     |
| Brazil                               | $672,834.48     | 4.17                     |
| China                                | $496,245.43     | 3.08                     |
| Italy                                | $476,572.90     | 2.96                     |
| India                                | $432,786.93     | 2.69                     |
| Spain                                | $364,657.10     | 2.26                     |
| Indonesia                            | $358,461.06     | 2.22                     |
| El Salvador                          | $322,654.93     | 2.00                     |
| Honduras                             | $320,781.88     | 1.99                     |
| Dominican Republic                   | $307,650.22     | 1.91                     |
| Cuba                                 | $295,628.69     | 1.83                     |
| Turkey                               | $284,993.67     | 1.77                     |
| Nicaragua                            | $252,642.57     | 1.57                     |
| Guatemala                            | $234,136.95     | 1.45                     |
| Nigeria                              | $219,649.53     | 1.36                     |
| Netherlands                          | $180,887.96     | 1.12                     |
| Philippines                          | $180,440.01     | 1.12                     |
| Panama                               | $177,676.19     | 1.10                     |
| Argentina                            | $162,312.33     | 1.01                     |
| Colombia                             | $151,183.86     | 0.94                     |
| Austria                              | $138,398.59     | 0.86                     |
| New Zealand                          | $132,142.73     | 0.82                     |
| Iran                                 | $132,959.54     | 0.82                     |
| Sweden                               | $98,723.57      | 0.61                     |
| Democratic Republic of the Congo    | $97,579.02      | 0.61                     |
| South Africa                         | $95,458.96      | 0.59                     |
| Morocco                              | $94,315.39      | 0.59                     |
| Egypt                                | $95,006.05      | 0.59                     |
| Ukraine                              | $92,823.02      | 0.58                     |
| Russia                               | $90,298.02      | 0.56                     |
| Iraq                                 | $80,221.68      | 0.50                     |
| Canada                               | $80,034.91      | 0.50                     |
| Venezuela                            | $80,178.13      | 0.50                     |
| Thailand                             | $76,421.56      | 0.47                     |
| Vietnam                              | $74,840.46      | 0.46                     |
| Japan                                | $71,231.40      | 0.44                     |
| Saudi Arabia                         | $65,962.97      | 0.41                     |
| Belgium                              | $63,282.87      | 0.39                     |
| Poland                               | $61,722.77      | 0.38                     |
| Pakistan                             | $61,762.57      | 0.38                     |
| Ireland                              | $58,412.76      | 0.36                     |
| Chile                                | $57,787.45      | 0.36                     |
| Peru                                  | $57,483.11      | 0.36                     |
| South Korea                          | $55,631.71      | 0.35                     |
| Haiti                                | $52,556.94      | 0.33                     |
| Malaysia                             | $46,545.04      | 0.29                     |
| Algeria                              | $40,389.83      | 0.25                     |
| Singapore                            | $37,894.74      | 0.24                     |
| Bangladesh                           | $37,741.93      | 0.23                     |
| Romania                              | $36,883.36      | 0.23                     |
| Portugal                             | $36,142.35      | 0.22                     |
| Denmark                              | $32,744.24      | 0.20                     |
| Tanzania                             | $32,288.68      | 0.20                     |
| Myanmar (Burma)                      | $31,169.84      | 0.19                     |
| Norway                               | $29,952.64      | 0.19                     |
| Cameroon                             | $29,362.73      | 0.18                     |
| Zambia                               | $28,324.50      | 0.18                     |
| Finland                              | $29,661.26      | 0.18                     |
| Kazakhstan                           | $25,070.80      | 0.16                     |
| Angola                               | $24,694.64      | 0.15                     |
| Switzerland                          | $24,673.59      | 0.15                     |
| Ivory Coast                          | $24,860.68      | 0.15                     |
| Ecuador                              | $24,239.44      | 0.15                     |
| Senegal                              | $22,254.38      | 0.14                     |
| Mozambique                            | $22,772.47      | 0.14                     |
| Israel                               | $21,273.57      | 0.13                     |
| Kenya                                | $21,322.71      | 0.13                     |
| Sudan                                | $19,763.50      | 0.12                     |
| Belarus                              | $19,183.01      | 0.12                     |
| Hungary                              | $17,827.89      | 0.11                     |
| Czech Republic                       | $18,294.57      | 0.11                     |
| Bolivia                              | $17,479.07      | 0.11                     |
| Uruguay                              | $15,630.29      | 0.10                     |
| Jamaica                               | $16,847.95      | 0.10                     |
| Bulgaria                              | $14,835.15      | 0.09                     |
| Ghana                                | $14,889.32      | 0.09                     |
| Uzbekistan                           | $12,818.45      | 0.08                     |
| Togo                                 | $13,554.57      | 0.08                     |
| Madagascar                           | $13,429.40      | 0.08                     |
| Afghanistan                          | $12,127.32      | 0.08                     |
| Cambodia                             | $12,986.72      | 0.08                     |
| Trinidad and Tobago                  | $12,918.40      | 0.08                     |
| Zimbabwe                             | $13,538.80      | 0.08                     |
| Georgia                              | $11,491.06      | 0.07                     |
| Lithuania                            | $11,118.59      | 0.07                     |
| Martinique                           | $11,536.60      | 0.07                     |
| Uganda                               | $10,534.79      | 0.07                     |
| Libya                                | $11,893.97      | 0.07                     |
| Kyrgyzstan                           | $8,879.10       | 0.06                     |
| Croatia                              | $8,900.20       | 0.06                     |
| Barbados                             | $9,734.97       | 0.06                     |
| Paraguay                             | $9,598.82       | 0.06                     |
| Mali                                 | $9,747.72       | 0.06                     |
| Jordan                               | $7,324.10       | 0.05                     |
| Rwanda                               | $7,904.27       | 0.05                     |
| Somalia                              | $7,455.14       | 0.05                     |
| Benin                                | $5,695.31       | 0.04                     |
| Papua New Guinea                      | $6,783.86       | 0.04                     |
| Azerbaijan                           | $5,973.41       | 0.04                     |
| Niger                                | $5,804.34       | 0.04                     |
| Yemen                                | $5,989.12       | 0.04                     |
| Slovakia                             | $4,089.62       | 0.03                     |
| Nepal                                | $5,132.21       | 0.03                     |
| Syria                                | $4,409.57       | 0.03                     |
| Guadeloupe                            | $4,299.58       | 0.03                     |
| Moldova                              | $5,168.25       | 0.03                     |
| Albania                              | $4,539.45       | 0.03                     |
| Turkmenistan                          | $5,071.33       | 0.03                     |
| Hong Kong                             | $4,909.89       | 0.03                     |
| Guinea                                | $3,049.58       | 0.02                     |
| Qatar                                | $2,604.61       | 0.02                     |
| Bosnia and Herzegovina                | $2,934.71       | 0.02                     |
| Namibia                               | $2,429.76       | 0.02                     |
| Mauritania                            | $3,089.67       | 0.02                     |
| Gabon                                 | $2,824.66       | 0.02                     |
| Mongolia                              | $2,665.62       | 0.02                     |
| Sierra Leone                          | $2,989.63       | 0.02                     |
| Greece                                | $2,429.66       | 0.02                     |
| Guinea-Bissau                         | $2,859.71       | 0.02                     |
| Taiwan                                | $2,511.18       | 0.02                     |
| North Macedonia                       | $1,099.90       | 0.01                     |
| Sri Lanka                             | $1,662.19       | 0.01                     |
| Costa Rica                            | $2,119.80       | 0.01                     |
| Ethiopia                              | $1,919.76       | 0.01                     |
| Oman                                  | $1,374.70       | 0.01                     |
| Eswatini                              | $1,259.91       | 0.01                     |
| Guyana                                | $1,929.69       | 0.01                     |
| Estonia                               | $1,357.84       | 0.01                     |
| Tunisia                               | $1,928.79       | 0.01                     |
| Lebanon                               | $1,387.76       | 0.01                     |
| Cyprus                                | $1,249.84       | 0.01                     |
| United Arab Emirates                  | $2,175.82       | 0.01                     |
| Montenegro                            | $1,699.80       | 0.01                     |
| Luxembourg                            | $1,129.86       | 0.01                     |
| Lesotho                               | $1,799.85       | 0.01                     |
| Central African Republic              | $2,069.63       | 0.01                     |
| Slovenia                              | $1,189.86       | 0.01                     |
| Liberia                               | $1,534.85       | 0.01                     |
| Gambia                                | $1,449.86       | 0.01                     |
| Djibouti                              | $909.86         | 0.01                     |
| Tajikistan                            | $749.94         | 0.00                     |
| Burkina Faso                          | $103.98         | 0.00                     |
| Republic of the Congo                 | $49.98          | 0.00                     |
| Laos                                  | $23.08          | 0.00                     |
| Suriname                              | $699.96         | 0.00                     |
| Belize                                | $669.90         | 0.00                     |
| Guayana Francesa                       | $674.80         | 0.00                     |
| Chad                                  | $599.96         | 0.00                     |
| Botswana                              | $149.94         | 0.00                     |


#### 3.) Find the cities with the most sales revenue throughout the dataset's duration and their contrubution percentage to total revenue.

```sql
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
```

| Order City         | Order Country         | Total Revenue   | Contribution Percentage |
|--------------------|-----------------------|-----------------|--------------------------|
| New York City      | United States         | $210,599.66     | 1.31                     |
| Santo Domingo      | Dominican Republic    | $185,620.93     | 1.15                     |
| Los Angeles        | United States         | $170,216.31     | 1.06                     |
| Tegucigalpa        | Honduras              | $150,078.56     | 0.93                     |
| Managua            | Nicaragua             | $137,424.30     | 0.85                     |
| Mexico City        | Mexico                | $125,729.95     | 0.78                     |
| Philadelphia       | United States         | $117,374.68     | 0.73                     |
| Manila             | Philippines           | $114,648.31     | 0.71                     |
| London             | United Kingdom        | $111,615.85     | 0.69                     |
| San Francisco      | United States         | $111,670.65     | 0.69                     |
| Viena              | Austria               | $104,917.23     | 0.65                     |
| San Salvador       | El Salvador           | $98,481.02      | 0.61                     |
| Seattle            | United States         | $96,847.54      | 0.60                     |
| Yakarta            | Indonesia             | $94,656.95      | 0.59                     |
| Berlín             | Germany               | $94,821.33      | 0.59                     |
| Lagos              | Nigeria               | $91,481.31      | 0.57                     |
| Buenos Aires       | Argentina             | $90,364.45      | 0.56                     |
| San Pedro Sula     | Honduras              | $81,416.16      | 0.51                     |
| Madrid             | Spain                 | $80,838.62      | 0.50                     |
| Houston            | United States         | $78,171.68      | 0.48                     |
| Sydney             | Australia             | $76,440.82      | 0.47                     |
| Panama City        | Panama                | $74,214.70      | 0.46                     |
| Paris              | France                | $73,625.39      | 0.46                     |
| Bangkok            | Thailand              | $74,543.41      | 0.46                     |
| Melbourne          | Australia             | $70,227.80      | 0.44                     |
| Chicago            | United States         | $70,766.30      | 0.44                     |
| Mixco              | Guatemala             | $66,014.88      | 0.41                     |
| Estambul           | Turkey                | $65,724.78      | 0.41                     |
| Hamburgo           | Germany               | $62,681.52      | 0.39                     |
| Estocolmo          | Sweden                | $63,548.75      | 0.39                     |


#### 4.) Find the regions generating the most sales revenue throughout the dataset's duration and their contribution percentage to total revenue.

```sql
SELECT Order_Region,
CONCAT('$', ROUND(SUM(Sales), 2)) AS total_revenue,
ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('Complete', 'Closed'))) * 100, 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Region
ORDER BY contribution_percentage DESC;
```

| Order Region       | Total Revenue   | Contribution Percentage |
|--------------------|-----------------|--------------------------|
| Western Europe     | $2,587,608.51   | 16.05                    |
| Central America    | $2,480,635.49   | 15.39                    |
| South America      | $1,252,031.44   | 7.77                     |
| Northern Europe    | $973,637.86     | 6.04                     |
| Southern Europe    | $901,415.77     | 5.59                     |
| Oceania            | $891,756.97     | 5.53                     |
| Southeast Asia     | $818,782.52     | 5.08                     |
| Caribbean          | $711,173.34     | 4.41                     |
| West of USA        | $698,172.78     | 4.33                     |
| South Asia         | $684,172.69     | 4.24                     |
| East of USA        | $636,348.52     | 3.95                     |
| Eastern Asia       | $633,195.23     | 3.93                     |
| US Center          | $512,914.66     | 3.18                     |
| West Asia          | $495,182.04     | 3.07                     |
| Eastern Europe     | $361,125.67     | 2.24                     |
| South of USA       | $333,651.00     | 2.07                     |
| West Africa        | $331,533.14     | 2.06                     |
| North Africa       | $263,297.54     | 1.63                     |
| East Africa        | $160,400.38     | 1.00                     |
| Central Africa     | $157,180.62     | 0.98                     |
| Southern Africa    | $101,098.42     | 0.63                     |
| Canada             | $80,034.91      | 0.50                     |
| Central Asia       | $52,589.62      | 0.33                     |


#### 5.) What are the customer demand trends over time?

```sql
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
```

| Order Year | Sales Revenue   | Number of Orders | Number of Unique Customers | Average Order Size | Total Quantity Ordered | Average Quantity Ordered |
|------------|-----------------|------------------|-----------------------------|---------------------|-------------------------|--------------------------|
| 2015       | $5,407,673.60   | 27,405           | 6,523                       | $197.32             | 60,593                  | 2.211                    |
| 2016       | $5,427,860.53   | 27,712           | 6,599                       | $195.87             | 60,694                  | 2.1902                   |
| 2017       | $5,132,901.25   | 23,034           | 7,996                       | $222.84             | 45,839                  | 1.9901                   |
| 2018       | $149,503.74     | 956              | 956                         | $156.38             | 956                     | 1                        |


#### 6.) What is the average sales value per order by each country?

```sql
SELECT Order_Country, COUNT(Order_Date) AS orders_placed, ROUND(AVG(Sales), 2) AS average_order_value, ROUND(AVG(Order_Profit_per_Order), 2) AS average_net_profit_per_order
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Order_Country
ORDER BY orders_placed DESC, average_net_profit_per_order DESC, average_order_value DESC;
```

| Order Country                     | Orders Placed | Average Order Value | Average Net Profit per Order |
|----------------------------------|---------------|---------------------|------------------------------|
| United States                     | 11,165        | $195.35             | $21.40                       |
| Mexico                            | 5,834         | $200.54             | $23.44                       |
| France                            | 5,790         | $221.26             | $26.60                       |
| Germany                           | 4,105         | $218.80             | $22.49                       |
| Australia                         | 3,783         | $199.00             | $21.64                       |
| Brazil                            | 3,409         | $197.37             | $22.78                       |
| United Kingdom                    | 3,157         | $225.43             | $26.29                       |
| China                             | 2,433         | $203.96             | $24.31                       |
| Italy                             | 2,250         | $211.81             | $26.74                       |
| India                             | 2,108         | $205.31             | $22.16                       |
| Indonesia                         | 1,813         | $197.72             | $19.50                       |
| Spain                             | 1,672         | $218.10             | $24.08                       |
| El Salvador                       | 1,621         | $199.05             | $20.34                       |
| Honduras                          | 1,588         | $202.00             | $21.47                       |
| Dominican Republic                | 1,586         | $193.98             | $24.07                       |
| Cuba                              | 1,459         | $202.62             | $16.23                       |
| Turkey                            | 1,451         | $196.41             | $19.66                       |
| Nicaragua                         | 1,265         | $199.72             | $19.86                       |
| Guatemala                         | 1,182         | $198.09             | $18.14                       |
| Nigeria                           | 1,121         | $195.94             | $23.23                       |
| Panama                            | 908           | $195.68             | $21.08                       |
| Philippines                       | 893           | $202.06             | $26.40                       |
| Argentina                         | 844           | $192.31             | $19.18                       |
| Netherlands                       | 831           | $217.68             | $25.57                       |
| Colombia                          | 793           | $190.65             | $22.24                       |
| New Zealand                       | 699           | $189.05             | $14.92                       |
| Iran                              | 667           | $199.34             | $25.80                       |
| Austria                           | 631           | $219.33             | $30.54                       |
| South Africa                      | 495           | $192.85             | $27.84                       |
| Egypt                             | 494           | $192.32             | $14.77                       |
| Morocco                           | 493           | $191.31             | $21.43                       |
| Democratic Republic of the Congo | 486           | $200.78             | $28.78                       |
| Ukraine                           | 475           | $195.42             | $16.87                       |
| Sweden                            | 458           | $215.55             | $21.50                       |
| Russia                            | 452           | $199.77             | $17.21                       |
| Iraq                              | 421           | $190.55             | $19.15                       |
| Canada                            | 410           | $195.21             | $20.90                       |
| Venezuela                         | 401           | $199.95             | $29.01                       |
| Thailand                          | 380           | $201.11             | $29.21                       |
| Saudi Arabia                      | 351           | $187.93             | $11.28                       |
| Japan                             | 340           | $209.50             | $11.98                       |
| Poland                            | 320           | $192.88             | $21.42                       |
| Vietnam                           | 319           | $234.61             | $27.35                       |
| Pakistan                          | 309           | $199.88             | $28.47                       |
| Peru                              | 308           | $186.63             | $16.42                       |
| Chile                             | 299           | $193.27             | $14.54                       |
| Haiti                             | 281           | $187.04             | $22.76                       |
| Belgium                           | 272           | $232.66             | $23.73                       |
| South Korea                       | 253           | $219.89             | $21.80                       |
| Malaysia                          | 239           | $194.75             | $28.84                       |
| Algeria                           | 218           | $185.27             | $20.21                       |
| Ireland                           | 216           | $270.43             | $20.54                       |
| Bangladesh                        | 195           | $193.55             | $29.96                       |
| Singapore                         | 187           | $202.65             | $16.48                       |
| Romania                           | 183           | $201.55             | $22.14                       |
| Tanzania                          | 171           | $188.82             | $26.90                       |
| Myanmar (Burma)                   | 165           | $188.91             | $15.12                       |
| Denmark                           | 155           | $211.25             | $17.11                       |
| Finland                           | 149           | $199.07             | $17.38                       |
| Cameroon                          | 147           | $199.75             | $32.81                       |
| Portugal                          | 146           | $247.55             | $47.45                       |
| Norway                            | 138           | $217.05             | $38.86                       |
| Zambia                            | 137           | $206.75             | $20.65                       |
| Ivory Coast                       | 132           | $188.34             | $21.41                       |
| Angola                            | 127           | $194.45             | $2.47                        |
| Kazakhstan                        | 125           | $200.57             | $28.47                       |
| Senegal                           | 124           | $179.47             | -$3.30                       |
| Switzerland                       | 119           | $207.34             | $29.11                       |
| Ecuador                           | 118           | $205.42             | -$2.91                       |
| Mozambique                         | 109           | $208.92             | $38.05                       |
| Kenya                             | 106           | $201.16             | $17.32                       |
| Sudan                             | 102           | $193.76             | $15.55                       |
| Israel                            | 100           | $212.74             | $28.54                       |
| Belarus                           | 95            | $201.93             | $20.21                       |
| Bolivia                           | 89            | $196.39             | $22.16                       |
| Czech Republic                    | 88            | $207.89             | $12.33                       |
| Hungary                           | 84            | $212.24             | $25.26                       |
| Jamaica                           | 81            | $208.00             | $46.43                       |
| Uruguay                           | 80            | $195.38             | $21.21                       |
| Ghana                             | 77            | $193.37             | $15.32                       |
| Trinidad and Tobago               | 72            | $179.42             | $22.79                       |
| Cambodia                          | 69            | $188.21             | $27.92                       |
| Bulgaria                          | 68            | $218.16             | $27.31                       |
| Madagascar                        | 67            | $200.44             | $33.33                       |
| Uzbekistan                        | 66            | $194.22             | $26.76                       |
| Togo                              | 66            | $205.37             | $4.71                        |
| Lithuania                         | 61            | $182.27             | $22.71                       |
| Zimbabwe                          | 60            | $225.65             | $27.20                       |
| Libya                             | 60            | $198.23             | $25.23                       |
| Martinique                         | 59            | $195.54             | $23.37                       |
| Uganda                            | 57            | $184.82             | $26.69                       |
| Georgia                           | 53            | $216.81             | $12.55                       |
| Barbados                          | 53            | $183.68             | $12.51                       |
| Afghanistan                       | 53            | $228.82             | $8.77                        |
| Mali                              | 51            | $191.13             | $22.75                       |
| Kyrgyzstan                         | 47            | $188.92             | $37.84                       |
| Paraguay                          | 45            | $213.31             | $13.34                       |
| Croatia                           | 44            | $202.28             | $22.53                       |
| Jordan                            | 43            | $170.33             | -$11.96                      |
| Rwanda                            | 36            | $219.56             | -$27.78                      |
| Papua New Guinea                  | 35            | $193.82             | $27.25                       |
| Somalia                           | 32            | $232.97             | $22.12                       |
| Benin                             | 32            | $177.98             | $18.64                       |
| Yemen                             | 30            | $199.64             | $16.95                       |
| Moldova                           | 27            | $191.42             | $7.73                        |
| Niger                             | 26            | $223.24             | $58.34                       |
| Azerbaijan                        | 25            | $238.94             | $0.92                        |
| Syria                             | 24            | $183.73             | $43.13                       |
| Turkmenistan                      | 24            | $211.31             | $0.08                        |
| Guadeloupe                         | 22            | $195.44             | $8.70                        |
| Albania                           | 20            | $226.97             | $51.32                       |
| Hong Kong                         | 20            | $245.49             | -$29.61                      |
| Nepal                             | 19            | $270.12             | $36.36                       |
| Slovakia                           | 19            | $215.24             | $25.96                       |
| Sierra Leone                       | 17            | $175.86             | -$12.29                      |
| Guinea                             | 16            | $190.60             | $54.74                       |
| Bosnia and Herzegovina             | 15            | $195.65             | -$15.25                      |
| Guinea-Bissau                      | 15            | $190.65             | -$51.76                      |
| Mauritania                         | 14            | $220.69             | $54.10                       |
| Gabon                              | 14            | $201.76             | $27.07                       |
| Tunisia                            | 14            | $137.77             | $20.35                       |
| Qatar                             | 13            | $200.35             | $62.51                       |
| Namibia                            | 13            | $186.90             | $4.44                        |
| Lebanon                            | 12            | $115.65             | $25.93                       |
| Greece                             | 12            | $202.47             | $19.33                       |
| Mongolia                           | 12            | $222.14             | $0.46                        |
| Ethiopia                           | 11            | $174.52             | $25.89                       |
| Lesotho                            | 11            | $163.62             | $15.31                       |
| Sri Lanka                          | 10            | $166.22             | $29.90                       |
| Costa Rica                         | 10            | $211.98             | $14.04                       |
| United Arab Emirates               | 10            | $217.58             | $13.90                       |
| Estonia                            | 10            | $135.78             | -$15.72                      |
| Taiwan                             | 10            | $251.12             | -$97.18                      |
| Liberia                            | 9             | $170.54             | $47.47                       |
| Guyana                             | 9             | $214.41             | $13.75                       |
| Central African Republic           | 9             | $229.96             | -$2.55                       |
| Montenegro                         | 8             | $212.48             | $64.60                       |
| Oman                               | 8             | $171.84             | $32.09                       |
| Cyprus                             | 8             | $156.23             | $23.82                       |
| Tajikistan                         | 6             | $124.99             | $35.90                       |
| Slovenia                           | 6             | $198.31             | $3.83                        |
| Eswatini                           | 5             | $251.98             | $62.49                       |
| Djibouti                           | 5             | $181.97             | $51.16                       |
| Luxembourg                         | 5             | $225.97             | $45.64                       |
| Gambia                             | 5             | $289.97             | -$53.17                      |
| North Macedonia                    | 4             | $274.98             | $62.86                       |
| Guayana Francesa                   | 4             | $168.70             | -$36.55                      |
| Belize                             | 4             | $167.48             | -$120.97                     |
| Suriname                           | 3             | $233.32             | $18.66                       |
| Chad                               | 3             | $199.99             | -$90.90                      |
| Laos                               | 2             | $11.54              | $4.03                        |
| Burkina Faso                       | 1             | $103.98             | $34.81                       |
| Republic of the Congo              | 1             | $49.98              | $20.44                       |
| Botswana                           | 1             | $149.94             | $3.19                        |


### Querying Customer Segmentation

#### 7.) What is the relationship between product category and sales performance? Which types of products have the highest product margins?

```sql
SELECT Category_Name, ROUND(SUM(Sales), 2) AS sales_revenue, ROUND(AVG(Benefit_per_order), 2) AS average_benefit_per_order, COUNT(Order_Date) AS orders_placed
FROM supplychaindata
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Category_Name
ORDER BY sales_revenue DESC, average_benefit_per_order DESC, orders_placed DESC
LIMIT 10;
```

| Category Name            | Sales Revenue | Average Benefit per Order | Orders Placed |
|--------------------------|---------------|----------------------------|---------------|
| Fishing                  | $3,022,248.96 | $44.24                     | 7,556         |
| Cleats                   | $1,934,378.24 | $21.14                     | 10,684        |
| Camping & Hiking         | $1,802,879.87 | $31.56                     | 6,010         |
| Cardio Equipment         | $1,639,187.25 | $32.57                     | 5,533         |
| Women's Apparel          | $1,387,000.00 | $17.20                     | 9,295         |
| Water Sports             | $1,342,783.01 | $21.61                     | 6,703         |
| Men's Footwear           | $1,279,971.66 | $13.66                     | 9,839         |
| Indoor/Outdoor Games     | $1,257,646.73 | $16.06                     | 8,442         |
| Shop By Sport            | $568,171.82   | $11.39                     | 4,803         |
| Computers                | $310,500.00   | $183.74                    | 207           |


#### 8.) How does benefit per order vary across different categories and customer segments?

```sql
SELECT Category_Name, Customer_Segment, ROUND(AVG(Benefit_per_order), 2) AS average_benefit_per_order, COUNT(Order_Date) AS orders_placed
FROM supplychaindata 
WHERE Order_Status IN ('Complete', 'Closed')
GROUP BY Category_Name, Customer_Segment
ORDER BY average_benefit_per_order DESC, orders_placed DESC
LIMIT 10;
```

| Category Name      | Customer Segment | Average Benefit per Order | Orders Placed |
|--------------------|-------------------|----------------------------|---------------|
| Computers          | Home Office       | $270.99                    | 28            |
| Computers          | Consumer          | $195.01                    | 112           |
| Strength Training  | Corporate         | $144.85                    | 12            |
| Computers          | Corporate         | $128.42                    | 67            |
| Basketball         | Home Office       | $126.49                    | 7             |
| Garden             | Consumer          | $97.72                     | 113           |
| Crafts             | Consumer          | $73.74                     | 129           |
| Crafts             | Corporate         | $71.90                     | 61            |
| Sporting Goods     | Home Office       | $69.62                     | 21            |
| Garden             | Corporate         | $66.47                     | 72            |


#### 9.) Which customer segment represents the largest portion of the company revenue?

```sql
SELECT 
Customer_Segment,
CONCAT('$', ROUND(SUM(Sales), 2)) AS sales_revenue,
ROUND(SUM(SALES) / (SELECT SUM(Sales) FROM supplychaindata WHERE Order_Status IN ('COMPLETE', 'CLOSED')), 2) AS contribution_percentage
FROM supplychaindata
WHERE Order_Status IN ('COMPLETE', 'CLOSED')
GROUP BY Customer_Segment
ORDER BY contribution_percentage DESC, sales_revenue DESC;
```

| Customer Segment | Sales Revenue   | Contribution Percentage |
|------------------|-----------------|--------------------------|
| Consumer         | $8,339,025.92   | 52%                      |
| Corporate        | $4,923,077.58   | 31%                      |
| Home Office      | $2,855,835.62   | 18%                      |


#### 10.) What is the rate of return or cancellation across product categories?

```sql
SELECT 
    Category_Name,
    COUNT(*) AS number_of_canceled_orders,                          # omit fraudulent orders from calculation for accuracy
    (COUNT(*) / (SELECT COUNT(*) FROM supplychaindata WHERE Order_Status != 'Suspected_Fraud') * 100) AS cancellation_rate 
FROM supplychaindata
WHERE Order_Status = 'CANCELED'
GROUP BY Category_Name
ORDER BY cancellation_rate DESC
LIMIT 10;
```

| Category Name            | Number of Canceled Orders | Cancellation Rate |
|--------------------------|----------------------------|-------------------|
| Cleats                   | 477                        | 27.03%            |
| Men's Footwear           | 467                        | 26.47%            |
| Women's Apparel          | 438                        | 24.82%            |
| Indoor/Outdoor Games     | 389                        | 22.05%            |
| Fishing                  | 336                        | 19.04%            |
| Water Sports             | 331                        | 18.76%            |
| Camping & Hiking         | 267                        | 15.13%            |
| Cardio Equipment         | 263                        | 14.90%            |
| Shop By Sport            | 241                        | 13.66%            |
| Electronics              | 55                         | 3.12%             |


#### 11.) What is the average profit ratio by category and how does it vary across regions? (most profitable categories by region)

```sql
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
```

| Category Name            | Market        | Average Profit Ratio |
|--------------------------|---------------|-----------------------|
| Cardio Equipment         | Africa        | 49.82                 |
| Fishing                  | Africa        | 44.29                 |
| Tennis & Racquet         | Africa        | 34.45                 |
| Water Sports             | Africa        | 28.04                 |
| Cleats                   | Africa        | 18.76                 |
| Computers                | Europe        | 207.38                |
| Basketball               | Europe        | 75.73                 |
| Crafts                   | Europe        | 67.82                 |
| Cameras                  | Europe        | 58.64                 |
| Women's Golf Clubs       | Europe        | 45.81                 |
| Soccer                   | LATAM         | 61.66                 |
| Golf Bags & Carts        | LATAM         | 50.16                 |
| Women's Golf Clubs       | LATAM         | 43.58                 |
| Fishing                  | LATAM         | 42.85                 |
| Strength Training        | LATAM         | 42.01                 |
| Computers                | Pacific Asia  | 88.03                 |
| Garden                   | Pacific Asia  | 77.95                 |
| Crafts                   | Pacific Asia  | 64.29                 |
| Children's Clothing      | Pacific Asia  | 49.76                 |
| Sporting Goods           | Pacific Asia  | 46.93                 |
| Fishing                  | USCA          | 51.03                 |
| Golf Shoes               | USCA          | 45.83                 |
| Boxing & MMA             | USCA          | 36.69                 |
| Camping & Hiking         | USCA          | 33.83                 |
| Cardio Equipment         | USCA          | 31.20                 |


#### 12.) What is the impact of discount rates on sales? 

```sql
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
```

| Discount Bucket  | Total Sales  | Average Discount | Sales Percentage |
|------------------|--------------|------------------|------------------|
| No Discount      | $656,609.61  | 0                | 5.43%            |
| Low Discount     | $2,668,031.94| 0.025            | 22.06%           |
| Medium Discount  | $4,688,548.10| 0.089            | 38.76%           |
| High Discount    | $4,082,125.30| 0.185            | 33.75%           |


#### 13.) Which products have the highest discount rates?

```sql
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
```

| Product Name                                               | Average Order Discount |
|------------------------------------------------------------|-------------------------|
| Bowflex SelectTech 1090 Dumbbells                         | 13.80%                  |
| SOLE E35 Elliptical                                       | 12.00%                  |
| Diamondback Boys' Insight 24 Performance Hybr             | 11.90%                  |
| LIJA Women's Mid-Length Panel Golf Shorts                  | 11.64%                  |
| Brooks Women's Ghost 6 Running Shoe                       | 11.47%                  |
| LIJA Women's Argyle Golf Polo                              | 11.33%                  |
| The North Face Women's Recon Backpack                      | 11.14%                  |
| Fitbit The One Wireless Activity & Sleep Tracker           | 11.08%                  |
| insta-bed Neverflat Air Mattress                           | 11.00%                  |
| Nike Men's Free TR 5.0 TB Training Shoe                    | 10.94%                  |
| Bridgestone e6 Straight Distance NFL San Diego Chargers    | 10.86%                  |
| Team Golf Pittsburgh Steelers Putter Grip                  | 10.84%                  |
| Team Golf Tennessee Volunteers Putter Grip                 | 10.76%                  |
| adidas Men's F10 Messi TRX FG Soccer Cleat                 | 10.74%                  |
| Yakima DoubleDown Ace Hitch Mount 4-Bike Rack              | 10.72%                  |


#### 14.) Create a product summary detailing the best selling products by quantity sold and profit margin.

```sql
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
```

| Product Name                                  | Product Card ID | Profit      | Quantity Sold | Average Profit per Order | Sales       | Profit Margin | Quantity Rank | Profit Margin Rank | Percentage of Total Quantity | Percentage of Total Sales |
|-----------------------------------------------|------------------|-------------|---------------|--------------------------|-------------|---------------|---------------|---------------------|------------------------------|---------------------------|
| Field & Stream Sportsman 16 Gun Fire Safe    | 1004             | 334,265.33  | 7556          | 44.24                    | 3,022,248.96| 11.06         | 7             | 64                  | 4.50                         | 18.75                     |
| Perfect Fitness Perfect Rip Deck             | 365              | 225,486.36  | 32,165        | 7.01                     | 1,929,578.40| 11.69         | 1             | 52                  | 19.14                        | 11.97                     |
| Diamondback Women's Serene Classic Comfort Bi| 957              | 189,689.09  | 6,010         | 31.56                    | 1,802,879.87| 10.52         | 9             | 75                  | 3.58                         | 11.19                     |
| Nike Men's Free 5.0+ Running Shoe            | 191              | 178,860.73  | 16,275        | 10.99                    | 1,627,337.25| 10.99         | 4             | 68                  | 9.68                         | 10.10                     |
| Nike Men's Dri-FIT Victory Golf Polo          | 502              | 159,854.55  | 27,740        | 5.76                     | 1,387,000.00| 11.53         | 2             | 55                  | 16.50                        | 8.61                      |
| Pelican Sunstream 100 Kayak                  | 1073             | 144,213.96  | 6,688         | 21.56                    | 1,337,533.16| 10.78         | 8             | 70                  | 3.98                         | 8.30                      |
| Nike Men's CJ Elite 2 TD Football Cleat      | 403              | 134,411.05  | 9,839         | 13.66                    | 1,279,971.66| 10.51         | 6             | 76                  | 5.85                         | 7.94                      |
| O'Brien Men's Neoprene Life Vest              | 1014             | 135,604.35  | 25,163        | 5.39                     | 1,257,646.73| 10.78         | 3             | 71                  | 14.97                        | 7.80                      |
| Under Armour Girls' Toddler Spine Surge Runni| 627              | 53,315.86   | 13,800        | 3.86                     | 551,862.01  | 9.66          | 5             | 82                  | 8.21                         | 3.42                      |
| Dell Laptop                                  | 1351             | 38,033.61   | 207           | 183.74                   | 310,500.00  | 12.25         | 64            | 45                  | 0.12                         | 1.93                      |
| Web Camera                                   | 1349             | 14,871.25   | 255           | 58.32                    | 115,270.20  | 12.90         | 58            | 41                  | 0.15                         | 0.72                      |
| Lawn mower                                   | 1355             | 16,524.61   | 212           | 77.95                    | 112,906.96  | 14.64         | 63            | 28                  | 0.13                         | 0.70                      |
| Porcelain crafts                             | 1353             | 14,639.50   | 222           | 65.94                    | 102,448.56  | 14.29         | 61            | 31                  | 0.13                         | 0.64                      |
| Children's heaters                           | 1350             | 11,940.20   | 278           | 42.95                    | 99,273.80   | 12.03         | 57            | 48                  | 0.17                         | 0.62                      |
| Summer dresses                               | 1363             | 8,767.47    | 284           | 30.87                    | 61,292.88   | 14.30         | 56            | 30                  | 0.17                         | 0.38                      |


### Querying Shipping Efficiency

#### 15.) What is the average Shipping time for different methods of transportation?

```sql
SELECT
    Shipping_Mode,
    Delivery_Status,
    AVG(Days_for_shipping_real) AS actual_delivery_time,
    AVG(Days_for_shipment_scheduled) AS scheduled_delivery_time
FROM supplychaindata
GROUP BY Shipping_Mode, Delivery_Status;
```

| Shipping Mode    | Delivery Status    | Actual Delivery Time | Scheduled Delivery Time |
|------------------|---------------------|-----------------------|--------------------------|
| Standard Class   | Advance shipping    | 2.4981                | 4                        |
| Standard Class   | Late delivery       | 5.5068                | 4                        |
| Standard Class   | Shipping on time    | 4                     | 4                        |
| Standard Class   | Shipping canceled   | 4.0454                | 4                        |
| First Class      | Late delivery       | 2                     | 1                        |
| Second Class     | Late delivery       | 4.4968                | 2                        |
| Second Class     | Shipping canceled   | 3.9348                | 2                        |
| Same Day         | Shipping on time    | 0                     | 0                        |
| Same Day         | Late delivery       | 1                     | 0                        |
| Same Day         | Shipping canceled   | 0.4572                | 0                        |
| Second Class     | Shipping on time    | 2                     | 2                        |
| First Class      | Shipping canceled   | 2                     | 1                        |


#### 16.) What percentage of orders arrive by the expected arrival date? (factoring only 'completed' or 'closed' orders)

```sql
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
```

| Percentage Early | Percentage On Time | Percentage Late |
|------------------|---------------------|-----------------|
| 23.95            | 18.78               | 57.27           |


#### 17.) What percentage of each shipping mode arrives on time or ahead of schedule?

```sql
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
```

| Shipping Mode     | Percentage On Time |
|-------------------|---------------------|
| First Class       | 0                   |
| Same Day          | 51.77               |
| Second Class      | 20.46               |
| Standard Class    | 60.41               |


#### 18.) What is the late delivery risk by region?

```sql
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
```

| Order Region        | Total Orders | Late Delivery Risk Percentage |
|---------------------|--------------|-------------------------------|
| South of USA        | 1733         | 61.4                          |
| South Asia          | 3361         | 60.04                         |
| Central Asia        | 268          | 59.7                          |
| Eastern Europe      | 1811         | 58.97                         |
| West Asia           | 2541         | 58.95                         |
| Southeast Asia      | 4067         | 58.69                         |
| East of USA         | 3236         | 58.68                         |
| Western Europe      | 11753        | 58.54                         |
| East Africa         | 791          | 58.53                         |
| Eastern Asia        | 3068         | 57.76                         |
| West of USA         | 3575         | 57.51                         |
| US Center           | 2621         | 57.15                         |
| Southern Europe     | 4185         | 57.08                         |
| Southern Africa     | 525          | 56.95                         |
| Northern Europe     | 4344         | 56.79                         |
| North Africa        | 1381         | 56.63                         |
| Central Africa      | 787          | 56.54                         |
| South America       | 6402         | 55.9                          |
| Central America     | 12412        | 55.85                         |
| Oceania             | 4517         | 55.74                         |
| Caribbean           | 3613         | 54.97                         |
| West Africa         | 1706         | 54.28                         |
| Canada              | 410          | 54.15                         |


#### 19.) What is the late delivery risk by country?

```sql
WITH DeliveryRisk AS (
    SELECT
        Order_Country, 
        Order_Region,
        COUNT(*) AS Total_Orders,
        COUNT(CASE WHEN Delivery_Status = 'Late delivery' THEN 1 END) AS Late_Deliveries
    FROM 
        supplychaindata
    WHERE
        Order_Status IN ('COMPLETE', 'CLOSED')
    GROUP BY
        Order_Country, Order_Region
)
SELECT
    Order_Country,
    Order_Region,
    Total_Orders,
    ROUND((Late_Deliveries * 100.0 / Total_Orders), 2) AS Late_Delivery_Risk_Percentage
FROM
    DeliveryRisk
WHERE 
	Total_Orders >= 30 -- only include countries that have at least 30 orders on record (for statistical significance)
ORDER BY
    Late_Delivery_Risk_Percentage DESC;
```

| Order Country                            | Order Region        | Total Orders | Late Delivery Risk Percentage |
|------------------------------------------|---------------------|--------------|-------------------------------|
| Somalia                                 | East Africa         | 32           | 90.63                         |
| Afghanistan                             | South Asia          | 53           | 79.25                         |
| Cambodia                                | Southeast Asia      | 69           | 78.26                         |
| Yemen                                    | West Asia           | 30           | 76.67                         |
| Georgia                                  | West Asia           | 53           | 75.47                         |
| Zimbabwe                                 | East Africa         | 60           | 73.33                         |
| Uganda                                   | East Africa         | 57           | 71.93                         |
| Trinidad and Tobago                      | Caribbean           | 72           | 70.83                         |
| Belarus                                  | Eastern Europe      | 95           | 70.53                         |
| Ireland                                  | Northern Europe     | 216          | 69.91                         |
| Jordan                                   | West Asia           | 43           | 69.77                         |
| Bolivia                                  | South America       | 89           | 69.66                         |
| Chile                                    | South America       | 299          | 67.22                         |
| Romania                                  | Eastern Europe      | 183          | 66.12                         |
| Israel                                   | West Asia           | 100          | 66                            |
| Norway                                   | Northern Europe     | 138          | 65.94                         |
| Croatia                                  | Southern Europe     | 44           | 65.91                         |
| Hungary                                  | Eastern Europe      | 84           | 65.48                         |
| Sweden                                   | Northern Europe     | 458          | 64.63                         |
| Ecuador                                  | South America       | 118          | 64.41                         |
| South Korea                              | Eastern Asia        | 253          | 64.03                         |
| Pakistan                                 | South Asia          | 309          | 63.75                         |
| Ghana                                    | West Africa         | 77           | 63.64                         |
| Mali                                     | West Africa         | 51           | 62.75                         |
| Ukraine                                  | Eastern Europe      | 475          | 62.32                         |
| Angola                                    | Central Africa      | 127          | 62.2                          |
| Saudi Arabia                             | West Asia           | 351          | 62.11                         |
| United States                            | South of USA        | 1733         | 61.4                          |
| Thailand                                 | Southeast Asia      | 380          | 61.32                         |
| Malaysia                                 | Southeast Asia      | 239          | 61.09                         |
| India                                    | South Asia          | 2108         | 60.1                          |
| Kazakhstan                               | Central Asia        | 125          | 60                            |
| Germany                                  | Western Europe      | 4105         | 59.95                         |
| El Salvador                              | Central America     | 1621         | 59.84                         |
| Mozambique                                | East Africa         | 109          | 59.63                         |
| Netherlands                              | Western Europe      | 831          | 59.33                         |
| Martinique                               | Caribbean           | 59           | 59.32                         |
| Jamaica                                  | Caribbean           | 81           | 59.26                         |
| Iran                                     | South Asia          | 667          | 59.22                         |
| Uzbekistan                               | Central Asia        | 66           | 59.09                         |
| Lithuania                                | Northern Europe     | 61           | 59.02                         |
| United States                            | East of USA         | 3236         | 58.68                         |
| Russia                                   | Eastern Europe      | 452          | 58.63                         |
| Turkey                                   | West Asia           | 1451         | 58.51                         |
| Indonesia                                | Southeast Asia      | 1813         | 58.47                         |
| Madagascar                               | East Africa         | 67           | 58.21                         |
| China                                    | Eastern Asia        | 2433         | 58.16                         |
| Democratic Republic of the Congo         | Central Africa      | 486          | 58.02                         |
| France                                   | Western Europe      | 5790         | 58.01                         |
| Philippines                              | Southeast Asia      | 893          | 58.01                         |
| Spain                                    | Southern Europe     | 1672         | 57.78                         |
| Morocco                                  | North Africa        | 493          | 57.61                         |
| Austria                                  | Western Europe      | 631          | 57.53                         |
| United States                            | West of USA         | 3575         | 57.51                         |
| Uruguay                                  | South America       | 80           | 57.5                          |
| Egypt                                    | North Africa        | 494          | 57.49                         |
| Kyrgyzstan                                | Central Asia        | 47           | 57.45                         |
| Venezuela                                | South America       | 401          | 57.36                         |
| Tanzania                                 | East Africa         | 171          | 57.31                         |
| Singapore                                | Southeast Asia      | 187          | 57.22                         |
| United States                            | US Center           | 2621         | 57.15                         |
| Ivory Coast                              | West Africa         | 132          | 56.82                         |
| Vietnam                                  | Southeast Asia      | 319          | 56.74                         |
| Nicaragua                                | Central America     | 1265         | 56.68                         |
| Italy                                    | Southern Europe     | 2250         | 56.58                         |
| Mexico                                   | Central America     | 5834         | 56.58                         |
| South Africa                             | Southern Africa     | 495          | 56.57                         |
| New Zealand                              | Oceania             | 699          | 56.51                         |
| Dominican Republic                       | Caribbean           | 1586         | 56.49                         |
| Brazil                                   | South America       | 3409         | 56.38                         |
| Togo                                     | West Africa         | 66           | 56.06                         |
| Sudan                                    | North Africa        | 102          | 55.88                         |
| Australia                                | Oceania             | 3783         | 55.67                         |
| Guatemala                                | Central America     | 1182         | 55.25                         |
| United Kingdom                           | Northern Europe     | 3157         | 55.21                         |
| Belgium                                  | Western Europe      | 272          | 55.15                         |
| Bangladesh                               | South Asia          | 195          | 54.87                         |
| Portugal                                 | Southern Europe     | 146          | 54.79                         |
| Barbados                                 | Caribbean           | 53           | 54.72                         |
| Honduras                                 | Central America     | 1588         | 54.22                         |
| Canada                                   | Canada              | 410          | 54.15                         |
| Nigeria                                  | West Africa         | 1121         | 54.06                         |
| Zambia                                   | East Africa         | 137          | 54.01                         |
| Argentina                                | South America       | 844          | 53.32                         |
| Peru                                     | South America       | 308          | 53.25                         |
| Algeria                                  | North Africa        | 218          | 53.21                         |
| Cuba                                     | Caribbean           | 1459         | 53.05                         |
| Iraq                                     | West Asia           | 421          | 52.73                         |
| Myanmar (Burma)                          | Southeast Asia      | 165          | 52.12                         |
| Japan                                    | Eastern Asia        | 340          | 51.76                         |
| Colombia                                 | South America       | 793          | 50.57                         |
| Poland                                   | Eastern Europe      | 320          | 50.31                         |
| Haiti                                    | Caribbean           | 281          | 50.18                         |
| Czech Republic                           | Eastern Europe      | 88           | 50                            |
| Papua New Guinea                         | Oceania             | 35           | 48.57                         |
| Finland                                  | Northern Europe     | 149          | 48.32                         |
| Cameroon                                 | Central Africa      | 147          | 47.62                         |
| Benin                                    | West Africa         | 32           | 46.88                         |
| Panama                                   | Central America     | 908          | 46.81                         |
| Kenya                                    | East Africa         | 106          | 46.23                         |
| Bulgaria                                 | Eastern Europe      | 68           | 45.59                         |
| Libya                                    | North Africa        | 60           | 45                            |
| Rwanda                                   | East Africa         | 36           | 44.44                         |
| Denmark                                  | Northern Europe     | 155          | 43.87                         |
| Senegal                                  | West Africa         | 124          | 41.94                         |
| Switzerland                              | Western Europe      | 119          | 41.18                         |
| Paraguay                                 | South America       | 45           | 40                            |


#### 20.) How is the customer retention rate of each customer segment?

```sql
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
```

| Current Year | Customer Segment | Total Customers Current Year | Retained Customers | Retention Rate | New Customers |
|--------------|------------------|------------------------------|---------------------|----------------|---------------|
| 2016         | Consumer         | 2815                         | 1166                | 41.42          | 1649          |
| 2016         | Corporate        | 1625                         | 708                 | 43.57          | 917           |
| 2016         | Home Office      | 961                          | 380                 | 39.54          | 581           |
| 2017         | Consumer         | 3245                         | 925                 | 28.51          | 2320          |
| 2017         | Corporate        | 1885                         | 546                 | 28.97          | 1339          |
| 2017         | Home Office      | 1095                         | 323                 | 29.5           | 772           |
| 2018         | Consumer         | 365                          | 0                   | 0              | 365           |
| 2018         | Corporate        | 196                          | 0                   | 0              | 196           |
| 2018         | Home Office      | 148                          | 0                   | 0              | 148           |


#### 21.) What is the overall customer retention rate?

```sql
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
```

| Current Year | Total Customers Current Year | Retained Customers | New Customers | Retention Rate |
|--------------|------------------------------|---------------------|---------------|----------------|
| 2016         | 5401                         | 2254                | 3147          | 41.73          |
| 2017         | 6225                         | 1794                | 4431          | 28.82          |
| 2018         | 709                          | 0                   | 709           | 0              |


## Step 4: Tableau Dashboard Development

[Tableau Dashboard Link]()
