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
- [Step 3: Querying & Analytics](#step-2-querying--analytics)
- [Step 4: Dashboard Development](#step-3-tableau-dashboard-development)

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

## Step 1. Importing Dataset into MySQL 

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
