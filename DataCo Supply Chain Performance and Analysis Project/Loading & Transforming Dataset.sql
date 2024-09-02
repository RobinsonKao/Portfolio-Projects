# Create New DataBase.
CREATE DATABASE supply_chain_big_data;

# Create Dummy Table to Import CSV and avoid datatype conflicts.
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

# Load the CSV Data into the TempTable.
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DataCoSupplyChainDataset.csv'
INTO TABLE TempSupplyChainData
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# Create the Actual Table and assign each column's datatype.
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

# Insert Formatted / Correctly Typed Data Into the Actual Table.
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

# Dropping Non-essential columns from dataset.
ALTER TABLE supplychaindata
DROP COLUMN Customer_Email,
DROP COLUMN Customer_Password,
DROP COLUMN Product_Description,
DROP COLUMN Product_Image;

# Disable Safe-Mode to enable editing for column values.
SET SQL_SAFE_UPDATES = 0;

# Translate 'Order_Country' names from Spanish to English.
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

# Create New Column "Year" by Extracting it from 'Order_Date' Column.
ALTER TABLE supplychaindata ADD COLUMN Order_Year INT;
UPDATE supplychaindata 
SET Order_Year= YEAR(Order_Date);

# Extract "Month" from 'Order_Date' into new column.
ALTER TABLE supplychaindata ADD COLUMN Order_Month INT;
UPDATE supplychaindata
SET Order_Month = MONTH(Order_Date);

# Re-enable Safe Mode.
SET SQL_SAFE_UPDATES = 1;

# View example rows of the remaining columns.
SELECT *
FROM supplychaindata
LIMIT 5;

# View Datatypes for each column.
DESCRIBE supplychaindata;