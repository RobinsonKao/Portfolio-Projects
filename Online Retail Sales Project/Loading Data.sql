-- Create a New Database to Conduct the Analysis
CREATE DATABASE Online_Retail_Analysis;

-- Create Table that CSV will Populate
CREATE TABLE Transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate VARCHAR(255),
    UnitPrice DECIMAL(10, 3),
    CustomerID  VARCHAR(20),
    Country VARCHAR(100)
);

-- Load the CSV into MySQL
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OnlineRetail.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Reformat InvoiceDate column to TIMESTAMP
-- Assuming your current InvoiceDate column is in a varchar format
-- Convert the varchar column into a datetime column
ALTER TABLE transactions
MODIFY COLUMN InvoiceDate DATETIME;
-- Update the InvoiceDate column to convert the existing string dates into datetime format
UPDATE transactions
SET InvoiceDate = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'); 