# 🛍 Online Retail Sales MySQL Data Analysis Project

## Objective

In this project, I conducted analytics and implemented an interactive dashboard highlighting the notable findings:

1. Sourced data from the UC Irvine Machine Learning Repository, processed the data from Excel into CSV, and read the file into MySQL for analysis.
2. Transformed and queried the data on MySQL through the implementation of preliminary and advanced querying techniques.
3. Exported the results of desired queries into Excel for further processing to be uploaded in Tableau for dashboard development.
4. Developed a dashboard on Tableau.

Given that this project is centered around MySQL, my primary focus lies in the realm of querying.

The sections below will explain additional details on the technologies and file utilized.

## Table of Content

- [Dataset Used](#dataset-used)
- [Technologies](#technologies)
- [Step 1: Sourcing and Loading Data](#step-1-loading-the-data-into-mysql)
- [Step 2: Querying & Analytics](#step-2-querying--analytics)
- [Step 3: Dashboard Development](#step-3-tableau-dashboard-development)

## Dataset Used

This project uses the transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail. The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

1.) InvoiceNo: This column holds unique identifiers for each transaction conducted. It serves a dual purpose by facilitating effortless identification of individual sales or purchases while simultaneously enabling treasury management through a repository for record-keeping.

2.) InvoiceDate: This column provides a date-time stamp associated with every transaction, revealing patterns in purchasing behavior over time and assisting with record-keeping requirements.

3.) StockCode: The StockCode is an alphanumeric sequence allocated distinctively to every item in stock. It aids in unequivocally identifying individual products, making inventory records seamless.

4.) Description: The Description field offers brief elucidations about each listed product, providing additional layers beyond just stock codes to aid potential customers' understanding of products better and make more informed choices.

5.) Quantity: Detailed logs concerning sold quantities come under the Quantity banner. It lists the units involved per transaction and aids calculations regarding total costs incurred during each sale/purchase, offering significant help in tracking inventory levels based on products' outflow dynamics within given periods.

6.) UnitPrice: Retail isn't merely about what you sell but also at what price you sell. This column documents unit prices exerted on items sold within transactions, providing pertinent pricing details that serve as pivotal factors driving metrics such as gross revenue calculation.

7.) Country: Finally yet importantly, our dive into foreign waters - literally! With impressive international outreach, we're looking into segmentation bases like geographical locations via documenting countries where transactions are conducted and consumers reside. This extends opportunities for businesses to map their customer bases, track regional performance metrics, extend localization efforts, and overall contributes to the formulation of efficient segmentation strategies.

More info about dataset can be found in the following links:

- Website: [Online Retail Data](https://archive.ics.uci.edu/dataset/352/online+retail)

## Technologies

The following technologies are used to build this project:

- Language: SQL
- Extraction and transformation: MySQL, Excel
- Dashboard: Tableau

## Step 1. Loading the Data into MySQL

In this step, I instantiated a new database (online_retail_analysis) for the project and created a new table (transactions) in MySQL to populate it with the CSV data.

#### Create a New Database to Conduct the Analysis

```sql
CREATE DATABASE Online_Retail_Analysis;
```
#### Create Table that CSV will Populate

```sql
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
```

#### Load the CSV into MySQL

```sql
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OnlineRetail.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

#### Here I reformat the "InvoiceDate" variable from Varchar (what I instantiated its variable as when I created the table) to MySQL's built-in TimeStamp.
##### Assuming your current InvoiceDate column is in a varchar format, convert the varchar column into a DateTime column.

```sql
ALTER TABLE transactions
MODIFY COLUMN InvoiceDate DATETIME;
-- Update the InvoiceDate column to convert the existing string dates into datetime format
UPDATE transactions
SET InvoiceDate = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'); 
```

#### Displaying sample rows of the data to familiarize with each of the variables.

```sql
SELECT *
FROM transactions
LIMIT 5;
```

| InvoiceNo | StockCode | Description                               | Quantity | InvoiceDate          | UnitPrice | CustomerID | Country        |
|-----------|-----------|-------------------------------------------|----------|----------------------|-----------|------------|----------------|
| 536365    | 85123A    | WHITE HANGING HEART T-LIGHT HOLDER        | 6        | 2010-12-01 8:26:00   | 2.55      | 17850      | United Kingdom |
| 536365    | 71053     | WHITE METAL LANTERN                       | 6        | 2010-12-01 8:26:00   | 3.39      | 17850      | United Kingdom |
| 536365    | 84406B    | CREAM CUPID HEARTS COAT HANGER            | 8        | 2010-12-01 8:26:00   | 2.75      | 17850      | United Kingdom |
| 536365    | 84029G    | KNITTED UNION FLAG HOT WATER BOTTLE       | 6        | 2010-12-01 8:26:00   | 3.39      | 17850      | United Kingdom |
| 536365    | 84029E    | RED WOOLLY HOTTIE WHITE HEART.            | 6        | 2010-12-01 8:26:00   | 3.39      | 17850      | United Kingdom |

## Step 2. Querying & Analytics

### Querying Revenue

#### 1.) Finding the Total Revenue, Cost of Goods Sold, and Net Profit generated in the year-long duration of the dataset.

```sql
SELECT 
CONCAT('$', ROUND(SUM(Revenue_Generated), 2)) AS Total_Revenue,
CONCAT('$', ROUND(ABS(SUM(COGS)), 2)) AS Total_COGS,
CONCAT('$',ROUND(SUM(Revenue_Generated) - SUM(ABS(COGS)), 2)) AS Total_NetProfit,
CONCAT(ROUND((SUM(Revenue_Generated) / (SUM(Revenue_Generated) + SUM(ABS(COGS)))) * 100, 2), '%') AS Revenue_Contribution_Percentage,
CONCAT(ROUND((SUM(ABS(COGS)) / (SUM(Revenue_Generated) + SUM(ABS(COGS)))) * 100, 2), '%') AS COGS_Contribution_Percentage,
CONCAT(ROUND(((SUM(Revenue_Generated) - SUM(ABS(COGS))) / (SUM(Revenue_Generated) + SUM(ABS(COGS)))) * 100, 2), '%') AS NetProfit_Contribution_Percentage
FROM
    (SELECT 
        SUM(Quantity * UnitPrice) AS Revenue_Generated
    FROM
        transactions
    WHERE
        Quantity > 0 AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT') AND Country != 'Unspecified') AS rev, # omit invoices that are refunds and miscellaneous transactions that aren't purchases
    (SELECT 
        SUM(Quantity * UnitPrice) AS COGS
    FROM
        transactions
    WHERE
        Quantity < 0) AS cogs;
```

| Total_Revenue   | Total_COGS     | Total_NetProfit | Revenue_Contribution_Percentage | COGS_Contribution_Percentage | NetProfit_Percentage |
|-----------------|----------------|-----------------|---------------------------------|------------------------------|-----------------------|
| $10,341,470.84  | $896,812.49    | $9,444,658.35   | 92.02%                          | 7.98%                        | 84.04%                |


#### 2.) Finding the Month-to-Month Revenue generated in the year-long duration of the dataset.

```sql
SELECT 
    YEAR(InvoiceDate) AS Year, # partition by year (2010 or 2011)
    MONTH(InvoiceDate) AS Month, # partition by month (1-12)
    ROUND(SUM(Quantity * UnitPrice), 2) AS Monthly_Revenue
FROM
    transactions
WHERE
    StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D','DOT') AND Quantity > 0 # omit invoices that are refunds and miscellaneous transactions that aren't a direct purchase
GROUP BY YEAR(InvoiceDate) , MONTH(InvoiceDate)
ORDER BY Year , Month;
```

| Year | Month | Monthly_Revenue |
|------|-------|-----------------|
| 2010 | 12    | 781088.62       |
| 2011 | 1     | 672289.31       |
| 2011 | 2     | 510405.32       |
| 2011 | 3     | 700252.32       |
| 2011 | 4     | 526818.29       |
| 2011 | 5     | 746932.97       |
| 2011 | 6     | 744354.76       |
| 2011 | 7     | 701055.54       |
| 2011 | 8     | 718255.14       |
| 2011 | 9     | 1037485.55      |
| 2011 | 10    | 1128935.16      |
| 2011 | 11    | 1462207.95      |
| 2011 | 12    | 616139.70       |


#### 3.) Displaying the Month-to-Month Revenue generated per country and cumulatively adding to their total accrued revenue.

```sql
SELECT 
    Country, 
    Year,
    Month,
    Monthly_Revenue,
    ROUND(@cumulative := IF(@prev_country = Country, @cumulative + Monthly_Revenue, Monthly_Revenue), 2) AS Cumulative_Revenue,
    @prev_country := Country AS dummy
FROM (
    SELECT 
        Country, 
        YEAR(InvoiceDate) AS Year, 
        MONTH(InvoiceDate) AS Month, 
        SUM(Quantity * UnitPrice) AS Monthly_Revenue
    FROM 
        transactions
    WHERE 
        Country != 'Unspecified' # omit unidentified countries
        AND Quantity > 0 # omit refunds/defective goods/lost goods
        AND StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'D', 'DOT') # omit transactions unrelated to the direct purchase
    GROUP BY 
        Country, 
        Year, 
        Month
    ORDER BY 
        Country, 
        Year, 
        Month
) AS MonthlyRevenue
CROSS JOIN 
    (SELECT @cumulative := 0, @prev_country := NULL) AS vars;
```

| **Country**           | **Year** | **Month** | **Monthly_Revenue** | **Cumulative_Revenue** |
|-----------------------|----------|-----------|---------------------|-------------------------|
| Australia             | 2010     | 12        | 1032.85             | 1032.85                 |
| Australia             | 2011     | 1         | 9017.71             | 10050.56                |
| Australia             | 2011     | 2         | 14695.42            | 24745.98                |
| Australia             | 2011     | 3         | 17223.99            | 41969.97                |
| Australia             | 2011     | 4         | 421.60              | 42391.57                |
| Australia             | 2011     | 5         | 13638.41            | 56029.98                |
| Australia             | 2011     | 6         | 25187.77            | 81217.75                |
| Australia             | 2011     | 7         | 4964.38             | 86182.13                |
| Australia             | 2011     | 8         | 22489.20            | 108671.33               |
| Australia             | 2011     | 9         | 5106.73             | 113778.06               |
| Australia             | 2011     | 10        | 17150.53            | 130928.59               |
| Australia             | 2011     | 11        | 7242.72             | 138171.31               |
| Australia             | 2011     | 12        | 6161.39             | 144332.70               |
| Austria               | 2010     | 12        | 157.20              | 157.20                  |
| Austria               | 2011     | 2         | 438.36              | 595.56                  |
| Austria               | 2011     | 3         | 1308.12             | 1903.68                 |
| Austria               | 2011     | 4         | 584.78              | 2488.46                 |
| Austria               | 2011     | 5         | 1049.43             | 3537.89                 |
| Austria               | 2011     | 7         | 1111.95             | 4649.84                 |
| Austria               | 2011     | 8         | 1436.08             | 6085.92                 |
| Austria               | 2011     | 10        | 923.78              | 7009.70                 |
| Austria               | 2011     | 11        | 1209.78             | 8219.48                 |
| Austria               | 2011     | 12        | 523.20              | 8742.68                 |
| Bahrain               | 2010     | 12        | 205.74              | 205.74                  |
| Bahrain               | 2011     | 5         | 548.40              | 754.14                  |
| Belgium               | 2010     | 12        | 1599.91             | 1599.91                 |
| Belgium               | 2011     | 1         | 1080.20             | 2680.11                 |
| Belgium               | 2011     | 2         | 1926.07             | 4606.18                 |
| Belgium               | 2011     | 3         | 2994.98             | 7601.16                 |
| Belgium               | 2011     | 4         | 1788.48             | 9389.64                 |
| Belgium               | 2011     | 5         | 2486.40             | 11876.04                |
| Belgium               | 2011     | 6         | 3848.82             | 15724.86                |
| Belgium               | 2011     | 7         | 2205.57             | 17930.43                |
| Belgium               | 2011     | 8         | 3140.02             | 21070.45                |
| Belgium               | 2011     | 9         | 3779.02             | 24849.47                |
| Belgium               | 2011     | 10        | 5169.38             | 30018.85                |
| Belgium               | 2011     | 11        | 5619.76             | 35638.61                |
| Belgium               | 2011     | 12        | 1288.73             | 36927.34                |
| Brazil                | 2011     | 4         | 1143.60             | 1143.60                 |
| Canada                | 2011     | 3         | 140.54              | 140.54                  |
| Canada                | 2011     | 5         | 534.24              | 674.78                  |
| Canada                | 2011     | 6         | 1171.46             | 1846.24                 |
| Canada                | 2011     | 7         | 1217.64             | 3063.88                 |
| Canada                | 2011     | 8         | 51.56               | 3115.44                 |
| Channel Islands       | 2010     | 12        | 363.53              | 363.53                  |
| Channel Islands       | 2011     | 1         | 675.58              | 1039.11                 |
| Channel Islands       | 2011     | 2         | 1784.71             | 2823.82                 |
| Channel Islands       | 2011     | 3         | 3509.33             | 6333.15                 |
| Channel Islands       | 2011     | 4         | 293.00              | 6626.15                 |
| Channel Islands       | 2011     | 5         | 1207.24             | 7833.39                 |
| Channel Islands       | 2011     | 6         | 2060.03             | 9893.42                 |
| Channel Islands       | 2011     | 8         | 4896.78             | 14790.20                |
| Channel Islands       | 2011     | 9         | 1323.75             | 16113.95                |
| Channel Islands       | 2011     | 10        | 2623.32             | 18737.27                |
| Channel Islands       | 2011     | 11        | 1514.77             | 20252.04                |
| Channel Islands       | 2011     | 12        | 198.40              | 20450.44                |
| Cyprus                | 2010     | 12        | 1590.82             | 1590.82                 |
| Cyprus                | 2011     | 1         | 547.50              | 2138.32                 |
| Cyprus                | 2011     | 2         | 4319.24             | 6457.56                 |
| Cyprus                | 2011     | 3         | 938.39              | 7395.95                 |
| Cyprus                | 2011     | 6         | 1109.32             | 8505.27                 |
| Cyprus                | 2011     | 9         | 196.35              | 8701.62                 |
| Cyprus                | 2011     | 10        | 4412.87             | 13114.49                |
| Cyprus                | 2011     | 11        | 460.89              | 13575.38                |
| Czech Republic        | 2011     | 2         | 549.26              | 549.26                  |
| Czech Republic        | 2011     | 10        | 237.48              | 786.74                  |
| Denmark               | 2010     | 12        | 1137.50             | 1137.50                 |
| Denmark               | 2011     | 2         | 363.22              | 1500.72                 |
| Denmark               | 2011     | 3         | 3978.99             | 5479.71                 |
| Denmark               | 2011     | 5         | 479.70              | 5959.41                 |
| Denmark               | 2011     | 6         | 3063.15             | 9022.56                 |
| Denmark               | 2011     | 7         | 358.24              | 9380.80                 |
| Denmark               | 2011     | 8         | 195.15              | 9575.95                 |
| Denmark               | 2011     | 9         | 4510.63             | 14086.58                |
| Denmark               | 2011     | 10        | 3208.52             | 17295.10                |
| Denmark               | 2011     | 11        | 4925.74             | 22220.84                |
| Denmark               | 2011     | 12        | 2297.58             | 24518.42                |
| Egypt                 | 2011     | 2         | 270.48              | 270.48                  |
| Egypt                 | 2011     | 3         | 214.89              | 485.37                  |
| Egypt                 | 2011     | 4         | 277.70              | 763.07                  |
| Egypt                 | 2011     | 6         | 90.14               | 853.21                  |
| Egypt                 | 2011     | 9         | 24.25               | 877.46                  |
| Egypt                 | 2011     | 10        | 50.84               | 928.30                  |
| Egypt                 | 2011     | 11        | 62.63               | 990.93                  |
| Egypt                 | 2011     | 12        | 50.75               | 1041.68                 |
| Finland               | 2010     | 12        | 1318.42             | 1318.42                 |
| Finland               | 2011     | 2         | 586.50              | 1904.92                 |
| Finland               | 2011     | 3         | 551.58              | 2456.50                 |
| Finland               | 2011     | 4         | 1149.60             | 3606.10                 |
| Finland               | 2011     | 5         | 821.77              | 4427.87                 |
| Finland               | 2011     | 6         | 1112.90             | 5540.77                 |
| Finland               | 2011     | 7         | 806.90              | 6347.67                 |
| Finland               | 2011     | 8         | 628.43              | 6976.10                 |
| Finland               | 2011     | 9         | 254.00              | 7230.10                 |
| Finland               | 2011     | 10        | 329.23              | 7559.33                 |
| Finland               | 2011     | 11        | 306.83              | 7866.16                 |
| Finland               | 2011     | 12        | 1084.37             | 8950.53                 |
| France                | 2010     | 12        | 13862.27            | 13862.27                |
| France                | 2011     | 1         | 15947.68            | 29809.95                |
| France                | 2011     | 2         | 7595.58             | 37405.53                |
| France                | 2011     | 3         | 5350.93             | 42756.46                |
| France                | 2011     | 4         | 6406.55             | 49163.01                |
| France                | 2011     | 5         | 7034.62             | 56297.63                |
| France                | 2011     | 6         | 8491.43             | 64789.06                |
| France                | 2011     | 7         | 11182.98            | 75972.04                |
| France                | 2011     | 8         | 13091.90            | 89063.94                |
| France                | 2011     | 9         | 10459.76            | 99523.70                |
| France                | 2011     | 10        | 11363.14            | 110886.84               |
| France                | 2011     | 11        | 6949.53             | 117836.37               |
| France                | 2011     | 12        | 9466.95             | 127303.32               |
| Germany               | 2010     | 12        | 2276.82             | 2276.82                 |
| Germany               | 2011     | 1         | 2991.62             | 5268.44                 |
| Germany               | 2011     | 2         | 4244.80             | 9513.24                 |
| Germany               | 2011     | 3         | 5879.78             | 15393.02                |
| Germany               | 2011     | 4         | 6012.89             | 21405.91                |
| Germany               | 2011     | 5         | 7472.95             | 28878.86                |
| Germany               | 2011     | 6         | 6672.18             | 35551.04                |
| Germany               | 2011     | 7         | 7120.82             | 42671.86                |
| Germany               | 2011     | 8         | 7143.32             | 49815.18                |
| Germany               | 2011     | 9         | 8001.28             | 57816.46                |
| Germany               | 2011     | 10        | 9490.61             | 67307.07                |
| Germany               | 2011     | 11        | 12499.31            | 79780.38                |
| Germany               | 2011     | 12        | 11811.96            | 91592.34                |
| Greece                | 2011     | 1         | 3222.83             | 3222.83                 |
| Greece                | 2011     | 2         | 2865.53             | 6088.36                 |
| Greece                | 2011     | 3         | 1548.96             | 7637.32                 |
| Greece                | 2011     | 4         | 2410.12             | 10047.44                |
| Greece                | 2011     | 5         | 4177.84             | 14225.28                |
| Greece                | 2011     | 6         | 1959.97             | 16185.25                |
| Greece                | 2011     | 7         | 2671.84             | 18857.09                |
| Greece                | 2011     | 8         | 5273.45             | 24130.54                |
| Greece                | 2011     | 9         | 4367.58             | 28498.12                |
| Greece                | 2011     | 10        | 4146.97             | 32645.09                |
| Greece                | 2011     | 11        | 4230.68             | 36875.77                |
| Greece                | 2011     | 12        | 2951.78             | 39827.55                |
| Hong Kong             | 2010     | 12        | 925.85              | 925.85                  |
| Hong Kong             | 2011     | 1         | 1216.42             | 2142.27                 |
| Hong Kong             | 2011     | 2         | 838.96              | 2981.23                 |
| Hong Kong             | 2011     | 3         | 2438.77             | 5419.99                 |
| Hong Kong             | 2011     | 4         | 1957.68             | 7377.67                 |
| Hong Kong             | 2011     | 5         | 2873.29             | 10250.96                |
| Hong Kong             | 2011     | 6         | 3399.87             | 13650.83                |
| Hong Kong             | 2011     | 7         | 2532.30             | 16183.13                |
| Hong Kong             | 2011     | 8         | 2548.89             | 18732.02                |
| Hong Kong             | 2011     | 9         | 2908.85             | 21640.87                |
| Hong Kong             | 2011     | 10        | 4235.61             | 25876.48                |
| Hong Kong             | 2011     | 11        | 2598.52             | 28474.99                |
| Hong Kong             | 2011     | 12        | 2025.88             | 30500.87                |
| Hungary               | 2011     | 2         | 733.13              | 733.13                  |
| Hungary               | 2011     | 3         | 531.91              | 1265.04                 |
| Hungary               | 2011     | 4         | 371.85              | 1636.89                 |
| Hungary               | 2011     | 5         | 438.13              | 2075.02                 |
| Hungary               | 2011     | 6         | 388.27              | 2463.29                 |
| Hungary               | 2011     | 7         | 269.89              | 2733.17                 |
| Hungary               | 2011     | 8         | 340.43              | 3073.60                 |
| Hungary               | 2011     | 9         | 362.65              | 3436.25                 |
| Hungary               | 2011     | 10        | 522.24              | 3958.49                 |
| Hungary               | 2011     | 11        | 539.41              | 4497.90                 |
| Hungary               | 2011     | 12        | 166.56              | 4664.46                 |
| India                 | 2010     | 12        | 7644.89             | 7644.89                 |
| India                 | 2011     | 1         | 10995.53            | 18640.42                |
| India                 | 2011     | 2         | 12064.59            | 30704.10                |
| India                 | 2011     | 3         | 13305.42            | 44009.52                |
| India                 | 2011     | 4         | 13185.36            | 57194.88                |
| India                 | 2011     | 5         | 15628.68            | 72823.56                |
| India                 | 2011     | 6         | 18050.61            | 90874.17                |
| India                 | 2011     | 7         | 21055.09            | 111929.26               |
| India                 | 2011     | 8         | 16262.54            | 128191.79               |
| India                 | 2011     | 9         | 10467.91            | 138659.70               |
| India                 | 2011     | 10        | 11858.22            | 150517.92               |
| India                 | 2011     | 11        | 11988.72            | 162506.64               |
| India                 | 2011     | 12        | 16854.51            | 179361.14               |
| Indonesia             | 2010     | 12        | 1738.97             | 1738.97                 |
| Indonesia             | 2011     | 1         | 2774.78             | 4513.75                 |
| Indonesia             | 2011     | 2         | 3886.71             | 8400.46                 |
| Indonesia             | 2011     | 3         | 5074.27             | 13474.73                |
| Indonesia             | 2011     | 4         | 3807.38             | 17282.11                |
| Indonesia             | 2011     | 5         | 3144.65             | 20426.76                |
| Indonesia             | 2011     | 6         | 3645.29             | 24072.05                |
| Indonesia             | 2011     | 7         | 3192.14             | 27264.19                |
| Indonesia             | 2011     | 8         | 4150.59             | 31414.78                |
| Indonesia             | 2011     | 9         | 4052.96             | 35467.73                |
| Indonesia             | 2011     | 10        | 3793.15             | 39260.88                |
| Indonesia             | 2011     | 11        | 3987.89             | 43248.77                |
| Indonesia             | 2011     | 12        | 3513.77             | 46762.54                |
| Ireland               | 2010     | 12        | 1418.76             | 1418.76                 |
| Ireland               | 2011     | 1         | 1807.99             | 3226.75                 |
| Ireland               | 2011     | 2         | 1242.65             | 4470.41                 |
| Ireland               | 2011     | 3         | 1249.92             | 5720.33                 |
| Ireland               | 2011     | 4         | 1224.31             | 6944.64                 |
| Ireland               | 2011     | 5         | 2165.71             | 9110.35                 |
| Ireland               | 2011     | 6         | 1177.40             | 10287.75                |
| Ireland               | 2011     | 7         | 2577.64             | 12865.39                |
| Ireland               | 2011     | 8         | 1172.32             | 14037.71                |
| Ireland               | 2011     | 9         | 1827.66             | 15865.37                |
| Ireland               | 2011     | 10        | 1442.93             | 17308.29                |
| Ireland               | 2011     | 11        | 1738.09             | 19046.38                |
| Ireland               | 2011     | 12        | 2270.89             | 21317.27                |
| Israel                | 2010     | 12        | 1578.77             | 1578.77                 |
| Israel                | 2011     | 1         | 3155.32             | 4734.09                 |
| Israel                | 2011     | 2         | 1976.68             | 6710.77                 |
| Israel                | 2011     | 3         | 1527.37             | 8238.14                 |
| Israel                | 2011     | 4         | 1595.64             | 9833.78                 |
| Israel                | 2011     | 5         | 1438.45             | 11272.23                |
| Israel                | 2011     | 6         | 2120.83             | 13393.06                |
| Israel                | 2011     | 7         | 1891.77             | 15284.83                |
| Israel                | 2011     | 8         | 2067.31             | 17352.14                |
| Israel                | 2011     | 9         | 1664.27             | 19016.41                |
| Israel                | 2011     | 10        | 1231.99             | 20248.40                |
| Israel                | 2011     | 11        | 1392.56             | 21640.96                |
| Israel                | 2011     | 12        | 1720.69             | 23361.65                |
| Italy                 | 2011     | 1         | 5804.66             | 5804.66                 |
| Italy                 | 2011     | 2         | 5383.20             | 11187.86                |
| Italy                 | 2011     | 3         | 3565.23             | 14753.09                |
| Italy                 | 2011     | 4         | 3742.34             | 18495.43                |
| Italy                 | 2011     | 5         | 2805.23             | 21300.66                |
| Italy                 | 2011     | 6         | 2475.64             | 23776.30                |
| Italy                 | 2011     | 7         | 3618.14             | 27394.44                |
| Italy                 | 2011     | 8         | 2842.72             | 30237.16                |
| Italy                 | 2011     | 9         | 3554.07             | 33791.23                |
| Italy                 | 2011     | 10        | 3724.27             | 37515.50                |
| Italy                 | 2011     | 11        | 4192.64             | 41608.14                |
| Italy                 | 2011     | 12        | 4077.54             | 45685.68                |
| Japan                 | 2010     | 12        | 2674.56             | 2674.56                 |
| Japan                 | 2011     | 1         | 2578.80             | 5253.36                 |
| Japan                 | 2011     | 2         | 3257.57             | 8510.93                 |
| Japan                 | 2011     | 3         | 2644.78             | 11155.71                |
| Japan                 | 2011     | 4         | 2350.92             | 13506.63                |
| Japan                 | 2011     | 5         | 2792.94             | 16299.56                |
| Japan                 | 2011     | 6         | 3326.26             | 19625.82                |
| Japan                 | 2011     | 7         | 3338.29             | 22964.11                |
| Japan                 | 2011     | 8         | 2585.93             | 25550.04                |
| Japan                 | 2011     | 9         | 3771.70             | 29321.73                |
| Japan                 | 2011     | 10        | 3438.09             | 32759.82                |
| Japan                 | 2011     | 11        | 2945.27             | 35705.09                |
| Japan                 | 2011     | 12        | 3548.93             | 39254.01                |
| Korea, South           | 2011     | 1         | 1643.28             | 1643.28                 |
| Korea, South           | 2011     | 2         | 1437.75             | 3081.03                 |
| Korea, South           | 2011     | 3         | 2110.97             | 5191.99                 |
| Korea, South           | 2011     | 4         | 2704.84             | 7896.83                 |
| Korea, South           | 2011     | 5         | 2290.23             | 10187.06                |
| Korea, South           | 2011     | 6         | 2425.12             | 12612.18                |
| Korea, South           | 2011     | 7         | 2330.69             | 14942.87                |
| Korea, South           | 2011     | 8         | 2152.66             | 17095.52                |
| Korea, South           | 2011     | 9         | 3063.71             | 20159.23                |
| Korea, South           | 2011     | 10        | 2271.25             | 22430.48                |
| Korea, South           | 2011     | 11        | 3122.25             | 25552.73                |
| Korea, South           | 2011     | 12        | 2234.64             | 27787.37                |
| Malaysia              | 2011     | 1         | 233.82              | 233.82                  |
| Malaysia              | 2011     | 2         | 558.57              | 792.39                  |
| Malaysia              | 2011     | 3         | 1372.26             | 2164.65                 |
| Malaysia              | 2011     | 4         | 1676.63             | 3841.28                 |
| Malaysia              | 2011     | 5         | 3061.04             | 6902.32                 |
| Malaysia              | 2011     | 6         | 2191.89             | 9094.21                 |
| Malaysia              | 2011     | 7         | 1467.58             | 10561.79                |
| Malaysia              | 2011     | 8         | 2623.35             | 13185.14                |
| Malaysia              | 2011     | 9         | 1368.72             | 14553.86                |
| Malaysia              | 2011     | 10        | 1433.58             | 15987.44                |
| Malaysia              | 2011     | 11        | 1384.72             | 17372.16                |
| Malaysia              | 2011     | 12        | 2028.42             | 19400.58                |
| Mexico                | 2010     | 12        | 5051.67             | 5051.67                 |
| Mexico                | 2011     | 1         | 6584.40             | 11636.07                |
| Mexico                | 2011     | 2         | 5772.79             | 17408.86                |
| Mexico                | 2011     | 3         | 5933.70             | 23342.56                |
| Mexico                | 2011     | 4         | 4175.60             | 27518.16                |
| Mexico                | 2011     | 5         | 3820.43             | 31338.59                |
| Mexico                | 2011     | 6         | 5356.80             | 36695.39                |
| Mexico                | 2011     | 7         | 5575.53             | 42270.92                |
| Mexico                | 2011     | 8         | 4424.21             | 46795.12                |
| Mexico                | 2011     | 9         | 4926.04             | 51721.16                |
| Mexico                | 2011     | 10        | 4175.30             | 55896.46                |
| Mexico                | 2011     | 11        | 4081.82             | 59978.28                |
| Mexico                | 2011     | 12        | 4115.84             | 64194.12                |
| Netherlands           | 2010     | 12        | 15058.64            | 15058.64                |
| Netherlands           | 2011     | 1         | 11414.59            | 26473.23                |
| Netherlands           | 2011     | 2         | 8535.59             | 35008.82                |
| Netherlands           | 2011     | 3         | 8660.04             | 43668.86                |
| Netherlands           | 2011     | 4         | 8056.70             | 51725.56                |
| Netherlands           | 2011     | 5         | 12084.45            | 63810.01                |
| Netherlands           | 2011     | 6         | 11376.65            | 75186.66                |
| Netherlands           | 2011     | 7         | 13142.68            | 88329.34                |
| Netherlands           | 2011     | 8         | 14227.63            | 102556.97               |
| Netherlands           | 2011     | 9         | 14854.89            | 117411.86               |
| Netherlands           | 2011     | 10        | 18832.15            | 136244.01               |
| Netherlands           | 2011     | 11        | 11847.58            | 148091.59               |
| Netherlands           | 2011     | 12        | 15827.37            | 163918.96               |
| Norway                | 2010     | 12        | 2462.51             | 2462.51                 |
| Norway                | 2011     | 1         | 3907.67             | 6370.18                 |
| Norway                | 2011     | 2         | 5204.98             | 11575.16                |
| Norway                | 2011     | 3         | 3300.35             | 14875.51                |
| Norway                | 2011     | 4         | 2545.59             | 17421.10                |
| Norway                | 2011     | 5         | 3958.93             | 21380.03                |
| Norway                | 2011     | 6         | 4527.98             | 25908.01                |
| Norway                | 2011     | 7         | 6344.90             | 32252.91                |
| Norway                | 2011     | 8         | 3745.36             | 35998.27                |
| Norway                | 2011     | 9         | 4475.64             | 40473.91                |
| Norway                | 2011     | 10        | 4501.99             | 44975.90                |
| Norway                | 2011     | 11        | 4275.16             | 49251.06                |
| Norway                | 2011     | 12        | 3299.56             | 52550.62                |
| Philippines            | 2010     | 12        | 1427.52             | 1427.52                 |
| Philippines            | 2011     | 1         | 1614.35             | 3041.87                 |
| Philippines            | 2011     | 2         | 1264.78             | 4306.65                 |
| Philippines            | 2011     | 3         | 1458.68             | 5765.33                 |
| Philippines            | 2011     | 4         | 1570.38             | 7335.71                 |
| Philippines            | 2011     | 5         | 2081.73             | 9417.44                 |
| Philippines            | 2011     | 6         | 2205.53             | 11622.97                |
| Philippines            | 2011     | 7         | 1245.16             | 12868.12                |
| Philippines            | 2011     | 8         | 1754.59             | 14622.71                |
| Philippines            | 2011     | 9         | 1846.53             | 16469.24                |
| Philippines            | 2011     | 10        | 1875.45             | 18344.69                |
| Philippines            | 2011     | 11        | 1380.19             | 19724.88                |
| Philippines            | 2011     | 12        | 1550.16             | 21275.04                |
| Poland                 | 2011     | 1         | 779.90              | 779.90                  |
| Poland                 | 2011     | 2         | 1187.88             | 1967.78                 |
| Poland                 | 2011     | 3         | 1094.76             | 3062.54                 |
| Poland                 | 2011     | 4         | 1061.83             | 3674.37                 |
| Poland                 | 2011     | 5         | 957.29              | 4631.66                 |
| Poland                 | 2011     | 6         | 1067.72             | 5699.37                 |
| Poland                 | 2011     | 7         | 1068.90             | 6768.27                 |
| Poland                 | 2011     | 8         | 1206.86             | 7975.13                 |
| Poland                 | 2011     | 9         | 1246.32             | 9221.45                 |
| Poland                 | 2011     | 10        | 1266.42             | 10487.87                |
| Poland                 | 2011     | 11        | 1187.83             | 11675.71                |
| Poland                 | 2011     | 12        | 1086.91             | 12762.62                |
| Portugal              | 2010     | 12         | 2456.50             | 2456.50                 |
| Portugal              | 2011     | 1         | 3058.55             | 5515.05                 |
| Portugal              | 2011     | 2         | 3230.34             | 8745.39                 |
| Portugal              | 2011     | 3         | 2519.18             | 11264.57                |
| Portugal              | 2011     | 4         | 3100.88             | 14365.45                |
| Portugal              | 2011     | 5         | 3042.87             | 17408.32                |
| Portugal              | 2011     | 6         | 2154.91             | 19563.23                |
| Portugal              | 2011     | 7         | 2727.40             | 22290.62                |
| Portugal              | 2011     | 8         | 2760.56             | 25051.17                |
| Portugal              | 2011     | 9         | 2907.84             | 27959.01                |
| Portugal              | 2011     | 10        | 3092.31             | 31051.32                |
| Portugal              | 2011     | 11        | 3286.26             | 34337.58                |
| Portugal              | 2011     | 12        | 2870.27             | 37207.85                |
| Romania                | 2011     | 1         | 1586.90             | 1586.90                 |
| Romania                | 2011     | 2         | 1851.82             | 3438.72                 |
| Romania                | 2011     | 3         | 1535.68             | 4974.40                 |
| Romania                | 2011     | 4         | 1697.43             | 6671.83                 |
| Romania                | 2011     | 5         | 1460.91             | 8132.74                 |
| Romania                | 2011     | 6         | 1981.58             | 10114.32                |
| Romania                | 2011     | 7         | 1474.87             | 11589.19                |
| Romania                | 2011     | 8         | 1970.83             | 13560.02                |
| Romania                | 2011     | 9         | 1632.35             | 15192.37                |
| Romania                | 2011     | 10        | 1418.65             | 16611.02                |
| Romania                | 2011     | 11        | 1880.66             | 18491.68                |
| Romania                | 2011     | 12        | 1910.77             | 20402.45                |
| Russia                | 2010     | 12         | 28941.95            | 28941.95                |
| Russia                | 2011     | 1         | 22064.50            | 51006.45                |
| Russia                | 2011     | 2         | 20807.58            | 71814.03                |
| Russia                | 2011     | 3         | 18718.52            | 90532.55                |
| Russia                | 2011     | 4         | 17769.48            | 108302.03               |
| Russia                | 2011     | 5         | 18818.16            | 127120.19               |
| Russia                | 2011     | 6         | 21681.23            | 148801.42               |
| Russia                | 2011     | 7         | 22383.82            | 171185.24               |
| Russia                | 2011     | 8         | 21345.35            | 192530.59               |
| Russia                | 2011     | 9         | 22124.51            | 214655.10               |
| Russia                | 2011     | 10        | 22468.76            | 237123.86               |
| Russia                | 2011     | 11        | 22160.74            | 259284.60               |
| Russia                | 2011     | 12        | 20659.63            | 279944.23               |
| Saudi Arabia           | 2010     | 12         | 5945.60             | 5945.60                 |
| Saudi Arabia           | 2011     | 1         | 5519.97             | 11465.57                |
| Saudi Arabia           | 2011     | 2         | 4779.79             | 16245.36                |
| Saudi Arabia           | 2011     | 3         | 4816.46             | 21061.82                |
| Saudi Arabia           | 2011     | 4         | 5046.72             | 26108.54                |
| Saudi Arabia           | 2011     | 5         | 4470.31             | 30578.85                |
| Saudi Arabia           | 2011     | 6         | 5767.95             | 36346.80                |
| Saudi Arabia           | 2011     | 7         | 6104.93             | 42451.73                |
| Saudi Arabia           | 2011     | 8         | 5771.60             | 48223.32                |
| Saudi Arabia           | 2011     | 9         | 6458.94             | 54682.26                |
| Saudi Arabia           | 2011     | 10        | 5178.86             | 59861.12                |
| Saudi Arabia           | 2011     | 11        | 4923.58             | 64784.70                |
| Saudi Arabia           | 2011     | 12        | 4780.52             | 69565.22                |
| Singapore              | 2010     | 12         | 6067.65             | 6067.65                 |
| Singapore              | 2011     | 1         | 6766.93             | 12834.58                |
| Singapore              | 2011     | 2         | 4977.97             | 17812.55                |
| Singapore              | 2011     | 3         | 6297.28             | 24109.83                |
| Singapore              | 2011     | 4         | 5560.56             | 29670.39                |
| Singapore              | 2011     | 5         | 7373.48             | 37043.87                |
| Singapore              | 2011     | 6         | 6100.95             | 43144.81                |
| Singapore              | 2011     | 7         | 7942.87             | 51087.67                |
| Singapore              | 2011     | 8         | 7647.35             | 58735.02                |
| Singapore              | 2011     | 9         | 7833.07             | 66568.09                |
| Singapore              | 2011     | 10        | 8285.36             | 74853.45                |
| Singapore              | 2011     | 11        | 6994.84             | 81848.29                |
| Singapore              | 2011     | 12        | 6598.65             | 88446.94                |
| South Africa           | 2010     | 12         | 1714.68             | 1714.68                 |
| South Africa           | 2011     | 1         | 2511.53             | 4226.21                 |
| South Africa           | 2011     | 2         | 2799.46             | 7025.67                 |
| South Africa           | 2011     | 3         | 3684.29             | 10709.96                |
| South Africa           | 2011     | 4         | 3108.63             | 13818.59                |
| South Africa           | 2011     | 5         | 3227.08             | 17045.66                |
| South Africa           | 2011     | 6         | 3606.70             | 20652.36                |
| South Africa           | 2011     | 7         | 3467.62             | 24119.98                |
| South Africa           | 2011     | 8         | 3594.36             | 27714.33                |
| South Africa           | 2011     | 9         | 3507.40             | 31221.73                |
| South Africa           | 2011     | 10        | 3751.14             | 34972.87                |
| South Africa           | 2011     | 11        | 3705.57             | 38678.43                |
| South Africa           | 2011     | 12        | 3721.64             | 42400.07                |
| Spain                  | 2010     | 12         | 3411.46             | 3411.46                 |
| Spain                  | 2011     | 1         | 3377.43             | 6788.89                 |
| Spain                  | 2011     | 2         | 3328.84             | 10117.73                |
| Spain                  | 2011     | 3         | 2757.62             | 12875.35                |
| Spain                  | 2011     | 4         | 2878.65             | 15753.99                |
| Spain                  | 2011     | 5         | 3242.65             | 18996.64                |
| Spain                  | 2011     | 6         | 3234.41             | 22231.05                |
| Spain                  | 2011     | 7         | 3485.90             | 25716.95                |
| Spain                  | 2011     | 8         | 3307.90             | 29024.85                |
| Spain                  | 2011     | 9         | 3474.13             | 32498.98                |
| Spain                  | 2011     | 10        | 3091.91             | 35590.89                |
| Spain                  | 2011     | 11        | 3407.96             | 38998.85                |
| Spain                  | 2011     | 12        | 3233.74             | 42232.59                |
| Sweden                 | 2010     | 12         | 3275.55             | 3275.55                 |
| Sweden                 | 2011     | 1         | 3190.95             | 6466.50                 |
| Sweden                 | 2011     | 2         | 3054.50             | 9520.99                 |
| Sweden                 | 2011     | 3         | 3231.75             | 12752.74                |
| Sweden                 | 2011     | 4         | 2691.56             | 15444.30                |
| Sweden                 | 2011     | 5         | 2920.97             | 18365.27                |
| Sweden                 | 2011     | 6         | 3658.76             | 22024.03                |
| Sweden                 | 2011     | 7         | 3180.26             | 25204.29                |
| Sweden                 | 2011     | 8         | 2863.99             | 28068.28                |
| Sweden                 | 2011     | 9         | 2520.71             | 30589.00                |
| Sweden                 | 2011     | 10        | 3483.14             | 34072.14                |
| Sweden                 | 2011     | 11        | 3174.05             | 37246.19                |
| Sweden                 | 2011     | 12        | 3258.71             | 40504.90                |
| Taiwan                 | 2011     | 1         | 1857.38             | 1857.38                 |
| Taiwan                 | 2011     | 2         | 1890.69             | 3748.07                 |
| Taiwan                 | 2011     | 3         | 1564.52             | 5312.59                 |
| Taiwan                 | 2011     | 4         | 1620.72             | 6933.31                 |
| Taiwan                 | 2011     | 5         | 1752.76             | 8686.07                 |
| Taiwan                 | 2011     | 6         | 2080.14             | 10766.21                |
| Taiwan                 | 2011     | 7         | 2255.26             | 13021.47                |
| Taiwan                 | 2011     | 8         | 2374.71             | 15396.17                |
| Taiwan                 | 2011     | 9         | 1887.25             | 17283.42                |
| Taiwan                 | 2011     | 10        | 2151.48             | 19434.90                |
| Taiwan                 | 2011     | 11        | 1863.51             | 21298.42                |
| Taiwan                 | 2011     | 12        | 2170.72             | 23469.13                |
| Thailand               | 2011     | 1         | 1822.12             | 1822.12                 |
| Thailand               | 2011     | 2         | 2271.95             | 3094.07                 |
| Thailand               | 2011     | 3         | 2180.13             | 5274.20                 |
| Thailand               | 2011     | 4         | 2930.48             | 8204.68                 |
| Thailand               | 2011     | 5         | 3198.19             | 11402.87                |
| Thailand               | 2011     | 6         | 2664.86             | 14067.73                |
| Thailand               | 2011     | 7         | 2677.28             | 16745.01                |
| Thailand               | 2011     | 8         | 3108.40             | 19853.41                |
| Thailand               | 2011     | 9         | 2774.48             | 22627.89                |
| Thailand               | 2011     | 10        | 3054.66             | 25682.54                |
| Thailand               | 2011     | 11        | 3052.91             | 28735.45                |
| Thailand               | 2011     | 12        | 2857.26             | 31592.71                |
| Turkey                 | 2010     | 12         | 2254.69             | 2254.69                 |
| Turkey                 | 2011     | 1         | 2296.67             | 2551.36                 |
| Turkey                 | 2011     | 2         | 2467.62             | 5018.98                 |
| Turkey                 | 2011     | 3         | 2913.23             | 7932.21                 |
| Turkey                 | 2011     | 4         | 2634.09             | 10566.30                |
| Turkey                 | 2011     | 5         | 3217.98             | 13784.28                |
| Turkey                 | 2011     | 6         | 2654.18             | 16438.46                |
| Turkey                 | 2011     | 7         | 2646.78             | 19085.24                |
| Turkey                 | 2011     | 8         | 2868.18             | 21953.42                |
| Turkey                 | 2011     | 9         | 2615.00             | 24568.42                |
| Turkey                 | 2011     | 10        | 2935.35             | 27503.77                |
| Turkey                 | 2011     | 11        | 3258.29             | 30762.06                |
| Turkey                 | 2011     | 12        | 2944.57             | 33706.63                |
| United Arab Emirates   | 2011     | 1         | 1667.42             | 1667.42                 |
| United Arab Emirates   | 2011     | 2         | 1522.35             | 3189.77                 |
| United Arab Emirates   | 2011     | 3         | 1593.38             | 4783.14                 |
| United Arab Emirates   | 2011     | 4         | 1863.32             | 6646.46                 |
| United Arab Emirates   | 2011     | 5         | 2083.90             | 8730.36                 |
| United Arab Emirates   | 2011     | 6         | 2331.14             | 11061.50                |
| United Arab Emirates   | 2011     | 7         | 2844.54             | 13906.04                |
| United Arab Emirates   | 2011     | 8         | 3094.75             | 16999.31                |
| United Arab Emirates   | 2011     | 9         | 2977.79             | 19977.10                |
| United Arab Emirates   | 2011     | 10        | 3396.84             | 23373.94                |
| United Arab Emirates   | 2011     | 11         | 2994.22             | 26368.16                |
| United Arab Emirates   | 2011     | 12         | 3190.57             | 29558.73                |
| United Kingdom         | 2010     | 12         | 28484.90            | 28484.90                |
| United Kingdom         | 2011     | 1         | 25743.85            | 54228.75                |
| United Kingdom         | 2011     | 2         | 22631.62            | 76860.37                |
| United Kingdom         | 2011     | 3         | 25704.45            | 102564.82               |
| United Kingdom         | 2011     | 4         | 28638.31            | 131203.13               |
| United Kingdom         | 2011     | 5         | 29104.81            | 160307.94               |
| United Kingdom         | 2011     | 6         | 31172.82            | 191480.76               |
| United Kingdom         | 2011     | 7         | 32693.28            | 224174.04               |
| United Kingdom         | 2011     | 8         | 34348.34            | 258522.38               |
| United Kingdom         | 2011     | 9         | 29205.98            | 287728.36               |
| United Kingdom         | 2011     | 10        | 30351.74            | 318080.10               |
| United Kingdom         | 2011     | 11        | 27413.71            | 345493.81               |
| United Kingdom         | 2011     | 12         | 27375.73            | 372869.54               |
| United States          | 2010     | 12         | 28585.54            | 28585.54                |
| United States          | 2011     | 1         | 28840.45            | 57425.99                |
| United States          | 2011     | 2         | 25856.61            | 83282.60                |
| United States          | 2011     | 3         | 31088.73            | 114371.33               |
| United States          | 2011     | 4         | 28976.81            | 143348.14               |
| United States          | 2011     | 5         | 32605.88            | 176954.02               |
| United States          | 2011     | 6         | 35632.46            | 212586.48               |
| United States          | 2011     | 7         | 36787.77            | 249374.25               |
| United States          | 2011     | 8         | 33836.04            | 283210.29               |
| United States          | 2011     | 9         | 32917.17            | 316127.46               |
| United States          | 2011     | 10        | 29390.56            | 345518.01               |
| United States          | 2011     | 11         | 30999.29            | 376517.30               |
| United States          | 2011     | 12         | 32678.96            | 409196.26               |


#### 4.) Displaying the Month-to-Month Revenue generated per country the percentage of the month's total revenue captured by that country.

```sql
SELECT 
    t.Country,
    YEAR(t.InvoiceDate) AS Year,
    MONTH(t.InvoiceDate) AS Month,
    ROUND((SUM(t.Quantity * t.UnitPrice) / total_revenue.Total_Revenue) * 100, 2) AS Percent_of_Total_Revenue,
    ROUND(total_revenue.Total_Revenue, 2) AS Total_Revenue_All_Countries
FROM
    transactions t
        JOIN
    (SELECT 
        YEAR(InvoiceDate) AS Year,
            MONTH(InvoiceDate) AS Month,
            SUM(Quantity * UnitPrice) AS Total_Revenue
    FROM
        transactions
    WHERE
        Country != 'Unspecified' # omit unidentified countries
            AND Quantity > 0  # omit refunds/defective goods/lost goods
            AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT') # omit transactions unrelated to the direct purchase
    GROUP BY YEAR(InvoiceDate) , MONTH(InvoiceDate)) AS total_revenue ON YEAR(t.InvoiceDate) = total_revenue.Year
        AND MONTH(t.InvoiceDate) = total_revenue.Month
WHERE
    t.Country != 'Unspecified' # omit unidentified countries
        AND t.Quantity > 0 # omit refunds/defective goods/lost goods
        AND t.StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES','CRUK','S','D','DOT') # omit transactions unrelated to the direct purchase
GROUP BY t.Country , YEAR(t.InvoiceDate) , MONTH(t.InvoiceDate) , total_revenue.Total_Revenue
ORDER BY t.Country , YEAR(t.InvoiceDate) , MONTH(t.InvoiceDate);
```

| Country            | Year | Month | Percent_of_Total_Revenue | Total_Revenue_All_Countries |
|--------------------|------|-------|---------------------------|------------------------------|
| Australia          | 2010 | 12    | 0.13                      | 781088.62                    |
| Australia          | 2011 | 1     | 1.34                      | 672289.31                    |
| Australia          | 2011 | 2     | 2.88                      | 510405.32                    |
| Australia          | 2011 | 3     | 2.46                      | 700252.32                    |
| Australia          | 2011 | 4     | 0.08                      | 526519.19                    |
| Australia          | 2011 | 5     | 1.83                      | 745877.10                    |
| Australia          | 2011 | 6     | 3.38                      | 744168.98                    |
| Australia          | 2011 | 7     | 0.71                      | 699630.13                    |
| Australia          | 2011 | 8     | 3.13                      | 717724.11                    |
| Australia          | 2011 | 9     | 0.49                      | 1037198.70                   |
| Australia          | 2011 | 10    | 1.52                      | 1128935.16                   |
| Australia          | 2011 | 11    | 0.50                      | 1461242.20                   |
| Austria            | 2010 | 12    | 0.02                      | 781088.62                    |
| Austria            | 2011 | 2     | 0.09                      | 510405.32                    |
| Austria            | 2011 | 3     | 0.19                      | 700252.32                    |
| Austria            | 2011 | 4     | 0.11                      | 526519.19                    |
| Austria            | 2011 | 5     | 0.14                      | 745877.10                    |
| Austria            | 2011 | 7     | 0.16                      | 699630.13                    |
| Austria            | 2011 | 8     | 0.20                      | 717724.11                    |
| Austria            | 2011 | 10    | 0.08                      | 1128935.16                   |
| Austria            | 2011 | 11    | 0.08                      | 1461242.20                   |
| Austria            | 2011 | 12    | 0.08                      | 616139.70                    |
| Bahrain            | 2010 | 12    | 0.03                      | 781088.62                    |
| Bahrain            | 2011 | 5     | 0.07                      | 745877.10                    |
| Belgium            | 2010 | 12    | 0.20                      | 781088.62                    |
| Belgium            | 2011 | 1     | 0.16                      | 672289.31                    |
| Belgium            | 2011 | 2     | 0.38                      | 510405.32                    |
| Belgium            | 2011 | 3     | 0.43                      | 700252.32                    |
| Belgium            | 2011 | 4     | 0.34                      | 526519.19                    |
| Belgium            | 2011 | 5     | 0.33                      | 745877.10                    |
| Belgium            | 2011 | 6     | 0.52                      | 744168.98                    |
| Belgium            | 2011 | 7     | 0.32                      | 699630.13                    |
| Belgium            | 2011 | 8     | 0.44                      | 717724.11                    |
| Belgium            | 2011 | 9     | 0.36                      | 1037198.70                   |
| Belgium            | 2011 | 10    | 0.46                      | 1128935.16                   |
| Belgium            | 2011 | 11    | 0.38                      | 1461242.20                   |
| Belgium            | 2011 | 12    | 0.21                      | 616139.70                    |
| Brazil             | 2011 | 4     | 0.22                      | 526519.19                    |
| Canada             | 2011 | 3     | 0.02                      | 700252.32                    |
| Canada             | 2011 | 5     | 0.07                      | 745877.10                    |
| Canada             | 2011 | 6     | 0.16                      | 744168.98                    |
| Canada             | 2011 | 7     | 0.17                      | 699630.13                    |
| Canada             | 2011 | 8     | 0.01                      | 717724.11                    |
| Channel Islands    | 2010 | 12    | 0.05                      | 781088.62                    |
| Channel Islands    | 2011 | 1     | 0.10                      | 672289.31                    |
| Channel Islands    | 2011 | 2     | 0.35                      | 510405.32                    |
| Channel Islands    | 2011 | 3     | 0.50                      | 700252.32                    |
| Channel Islands    | 2011 | 4     | 0.06                      | 526519.19                    |
| Channel Islands    | 2011 | 5     | 0.16                      | 745877.10                    |
| Channel Islands    | 2011 | 6     | 0.28                      | 744168.98                    |
| Channel Islands    | 2011 | 8     | 0.68                      | 717724.11                    |
| Channel Islands    | 2011 | 9     | 0.13                      | 1037198.70                   |
| Channel Islands    | 2011 | 10    | 0.23                      | 1128935.16                   |
| Channel Islands    | 2011 | 11    | 0.10                      | 1461242.20                   |
| Channel Islands    | 2011 | 12    | 0.03                      | 616139.70                    |
| Cyprus             | 2010 | 12    | 0.20                      | 781088.62                    |
| Cyprus             | 2011 | 1     | 0.08                      | 672289.31                    |
| Cyprus             | 2011 | 2     | 0.85                      | 510405.32                    |
| Cyprus             | 2011 | 3     | 0.13                      | 700252.32                    |
| Cyprus             | 2011 | 6     | 0.15                      | 744168.98                    |
| Cyprus             | 2011 | 9     | 0.02                      | 1037198.70                   |
| Cyprus             | 2011 | 10    | 0.39                      | 1128935.16                   |
| Cyprus             | 2011 | 11    | 0.03                      | 1461242.20                   |
| Czech Republic     | 2011 | 2     | 0.11                      | 510405.32                    |
| Czech Republic     | 2011 | 10    | 0.02                      | 1128935.16                   |
| Denmark            | 2010 | 12    | 0.15                      | 781088.62                    |
| Denmark            | 2011 | 2     | 0.07                      | 510405.32                    |
| Denmark            | 2011 | 3     | 0.57                      | 700252.32                    |
| Denmark            | 2011 | 5     | 0.06                      | 745877.10                    |
| Denmark            | 2011 | 6     | 0.41                      | 744168.98                    |
| Denmark            | 2011 | 7     | 0.05                      | 699630.13                    |
| Denmark            | 2011 | 8     | 0.03                      | 717724.11                    |
| Denmark            | 2011 | 9     | 0.43                      | 1037198.70                   |
| Denmark            | 2011 | 10    | 0.11                      | 1128935.16                   |
| Denmark            | 2011 | 11    | 0.18                      | 1461242.20                   |
| Denmark            | 2011 | 12    | 0.02                      | 616139.70                    |
| EIRE               | 2010 | 12    | 1.28                      | 781088.62                    |
| EIRE               | 2011 | 1     | 3.26                      | 672289.31                    |
| EIRE               | 2011 | 2     | 0.56                      | 510405.32                    |
| EIRE               | 2011 | 3     | 1.78                      | 700252.32                    |
| EIRE               | 2011 | 4     | 2.29                      | 526519.19                    |
| EIRE               | 2011 | 5     | 1.94                      | 745877.10                    |
| EIRE               | 2011 | 6     | 1.82                      | 744168.98                    |
| EIRE               | 2011 | 7     | 2.08                      | 699630.13                    |
| EIRE               | 2011 | 8     | 2.04                      | 717724.11                    |
| EIRE               | 2011 | 9     | 2.15                      | 1037198.70                   |
| EIRE               | 2011 | 10    | 2.10                      | 1128935.16                   |
| EIRE               | 2011 | 11    | 1.81                      | 1461242.20                   |
| EIRE               | 2011 | 12    | 1.62                      | 616139.70                    |
| Finland            | 2010 | 12    | 0.04                      | 781088.62                    |
| Finland            | 2011 | 1     | 0.23                      | 672289.31                    |
| Finland            | 2011 | 2     | 0.15                      | 510405.32                    |
| Finland            | 2011 | 3     | 0.08                      | 700252.32                    |
| Finland            | 2011 | 5     | 0.07                      | 745877.10                    |
| Finland            | 2011 | 6     | 0.03                      | 744168.98                    |
| Finland            | 2011 | 7     | 0.07                      | 699630.13                    |
| Finland            | 2011 | 8     | 0.07                      | 717724.11                    |
| Finland            | 2011 | 9     | 0.22                      | 1037198.70                   |
| Finland            | 2011 | 10    | 0.22                      | 1128935.16                   |
| Finland            | 2011 | 11    | 0.03                      | 1461242.20                   |
| Finland            | 2011 | 12    | 0.03                      | 616139.70                    |
| France             | 2010 | 12    | 0.40                      | 781088.62                    |
| France             | 2011 | 1     | 0.41                      | 672289.31                    |
| France             | 2011 | 2     | 0.53                      | 510405.32                    |
| France             | 2011 | 3     | 0.55                      | 700252.32                    |
| France             | 2011 | 4     | 0.63                      | 526519.19                    |
| France             | 2011 | 5     | 0.51                      | 745877.10                    |
| France             | 2011 | 6     | 0.62                      | 744168.98                    |
| France             | 2011 | 7     | 0.39                      | 699630.13                    |
| France             | 2011 | 8     | 0.39                      | 717724.11                    |
| France             | 2011 | 9     | 0.45                      | 1037198.70                   |
| France             | 2011 | 10    | 0.36                      | 1128935.16                   |
| France             | 2011 | 11    | 0.27                      | 1461242.20                   |
| France             | 2011 | 12    | 0.19                      | 616139.70                    |
| Germany            | 2010 | 12    | 0.16                      | 781088.62                    |
| Germany            | 2011 | 1     | 0.07                      | 672289.31                    |
| Germany            | 2011 | 2     | 0.35                      | 510405.32                    |
| Germany            | 2011 | 3     | 0.37                      | 700252.32                    |
| Germany            | 2011 | 4     | 0.44                      | 526519.19                    |
| Germany            | 2011 | 5     | 0.35                      | 745877.10                    |
| Germany            | 2011 | 6     | 0.32                      | 744168.98                    |
| Germany            | 2011 | 7     | 0.32                      | 699630.13                    |
| Germany            | 2011 | 8     | 0.32                      | 717724.11                    |
| Germany            | 2011 | 9     | 0.37                      | 1037198.70                   |
| Germany            | 2011 | 10    | 0.27                      | 1128935.16                   |
| Germany            | 2011 | 11    | 0.35                      | 1461242.20                   |
| Germany            | 2011 | 12    | 0.30                      | 616139.70                    |
| Greece             | 2010 | 12    | 0.09                      | 781088.62                    |
| Greece             | 2011 | 1     | 0.08                      | 672289.31                    |
| Greece             | 2011 | 2     | 0.13                      | 510405.32                    |
| Greece             | 2011 | 3     | 0.13                      | 700252.32                    |
| Greece             | 2011 | 4     | 0.04                      | 526519.19                    |
| Greece             | 2011 | 5     | 0.08                      | 745877.10                    |
| Greece             | 2011 | 6     | 0.04                      | 744168.98                    |
| Greece             | 2011 | 7     | 0.12                      | 699630.13                    |
| Greece             | 2011 | 8     | 0.07                      | 717724.11                    |
| Greece             | 2011 | 9     | 0.08                      | 1037198.70                   |
| Greece             | 2011 | 10    | 0.06                      | 1128935.16                   |
| Greece             | 2011 | 11    | 0.06                      | 1461242.20                   |
| Greece             | 2011 | 12    | 0.06                      | 616139.70                    |
| Hungary            | 2011 | 2     | 0.04                      | 510405.32                    |
| Hungary            | 2011 | 10    | 0.10                      | 1128935.16                   |
| Iceland            | 2010 | 12    | 0.01                      | 781088.62                    |
| Iceland            | 2011 | 1     | 0.11                      | 672289.31                    |
| Iceland            | 2011 | 2     | 0.07                      | 510405.32                    |
| Iceland            | 2011 | 3     | 0.06                      | 700252.32                    |
| Iceland            | 2011 | 5     | 0.03                      | 745877.10                    |
| Iceland            | 2011 | 6     | 0.02                      | 744168.98                    |
| Iceland            | 2011 | 7     | 0.04                      | 699630.13                    |
| Iceland            | 2011 | 8     | 0.05                      | 717724.11                    |
| Iceland            | 2011 | 9     | 0.06                      | 1037198.70                   |
| Iceland            | 2011 | 10    | 0.03                      | 1128935.16                   |
| Iceland            | 2011 | 11    | 0.02                      | 1461242.20                   |
| Iceland            | 2011 | 12    | 0.02                      | 616139.70                    |
| India              | 2010 | 12    | 0.14                      | 781088.62                    |
| India              | 2011 | 1     | 0.13                      | 672289.31                    |
| India              | 2011 | 2     | 0.12                      | 510405.32                    |
| India              | 2011 | 3     | 0.13                      | 700252.32                    |
| India              | 2011 | 4     | 0.16                      | 526519.19                    |
| India              | 2011 | 5     | 0.14                      | 745877.10                    |
| India              | 2011 | 6     | 0.16                      | 744168.98                    |
| India              | 2011 | 7     | 0.14                      | 699630.13                    |
| India              | 2011 | 8     | 0.16                      | 717724.11                    |
| India              | 2011 | 9     | 0.14                      | 1037198.70                   |
| India              | 2011 | 10    | 0.15                      | 1128935.16                   |
| India              | 2011 | 11    | 0.14                      | 1461242.20                   |
| India              | 2011 | 12    | 0.14                      | 616139.70                    |
| Italy              | 2010 | 12    | 0.23                      | 781088.62                    |
| Italy              | 2011 | 1     | 0.23                      | 672289.31                    |
| Italy              | 2011 | 2     | 0.19                      | 510405.32                    |
| Italy              | 2011 | 3     | 0.23                      | 700252.32                    |
| Italy              | 2011 | 4     | 0.22                      | 526519.19                    |
| Italy              | 2011 | 5     | 0.22                      | 745877.10                    |
| Italy              | 2011 | 6     | 0.25                      | 744168.98                    |
| Italy              | 2011 | 7     | 0.26                      | 699630.13                    |
| Italy              | 2011 | 8     | 0.27                      | 717724.11                    |
| Italy              | 2011 | 9     | 0.23                      | 1037198.70                   |
| Italy              | 2011 | 10    | 0.24                      | 1128935.16                   |
| Italy              | 2011 | 11    | 0.22                      | 1461242.20                   |
| Italy              | 2011 | 12    | 0.21                      | 616139.70                    |
| Lithuania          | 2010 | 12    | 0.05                      | 781088.62                    |
| Lithuania          | 2011 | 1     | 0.02                      | 672289.31                    |
| Lithuania          | 2011 | 2     | 0.04                      | 510405.32                    |
| Lithuania          | 2011 | 3     | 0.06                      | 700252.32                    |
| Lithuania          | 2011 | 4     | 0.08                      | 526519.19                    |
| Lithuania          | 2011 | 5     | 0.05                      | 745877.10                    |
| Lithuania          | 2011 | 6     | 0.06                      | 744168.98                    |
| Lithuania          | 2011 | 7     | 0.07                      | 699630.13                    |
| Lithuania          | 2011 | 8     | 0.08                      | 717724.11                    |
| Lithuania          | 2011 | 9     | 0.05                      | 1037198.70                   |
| Lithuania          | 2011 | 10    | 0.08                      | 1128935.16                   |
| Lithuania          | 2011 | 11    | 0.05                      | 1461242.20                   |
| Lithuania          | 2011 | 12    | 0.05                      | 616139.70                    |
| Luxembourg         | 2010 | 12    | 0.08                      | 781088.62                    |
| Luxembourg         | 2011 | 1     | 0.07                      | 672289.31                    |
| Luxembourg         | 2011 | 2     | 0.04                      | 510405.32                    |
| Luxembourg         | 2011 | 3     | 0.07                      | 700252.32                    |
| Luxembourg         | 2011 | 4     | 0.05                      | 526519.19                    |
| Luxembourg         | 2011 | 5     | 0.05                      | 745877.10                    |
| Luxembourg         | 2011 | 6     | 0.06                      | 744168.98                    |
| Luxembourg         | 2011 | 7     | 0.09                      | 699630.13                    |
| Luxembourg         | 2011 | 8     | 0.07                      | 717724.11                    |
| Luxembourg         | 2011 | 9     | 0.09                      | 1037198.70                   |
| Luxembourg         | 2011 | 10    | 0.10                      | 1128935.16                   |
| Luxembourg         | 2011 | 11    | 0.05                      | 1461242.20                   |
| Luxembourg         | 2011 | 12    | 0.05                      | 616139.70                    |
| Malta              | 2010 | 12    | 0.01                      | 781088.62                    |
| Malta              | 2011 | 1     | 0.02                      | 672289.31                    |
| Malta              | 2011 | 2     | 0.01                      | 510405.32                    |
| Malta              | 2011 | 3     | 0.01                      | 700252.32                    |
| Malta              | 2011 | 4     | 0.01                      | 526519.19                    |
| Malta              | 2011 | 5     | 0.01                      | 745877.10                    |
| Malta              | 2011 | 6     | 0.02                      | 744168.98                    |
| Malta              | 2011 | 7     | 0.01                      | 699630.13                    |
| Malta              | 2011 | 8     | 0.01                      | 717724.11                    |
| Malta              | 2011 | 9     | 0.01                      | 1037198.70                   |
| Malta              | 2011 | 10    | 0.01                      | 1128935.16                   |
| Malta              | 2011 | 11    | 0.01                      | 1461242.20                   |
| Malta              | 2011 | 12    | 0.01                      | 616139.70                    |
| Netherlands        | 2010 | 12    | 0.18                      | 781088.62                    |
| Netherlands        | 2011 | 1     | 0.11                      | 672289.31                    |
| Netherlands        | 2011 | 2     | 0.11                      | 510405.32                    |
| Netherlands        | 2011 | 3     | 0.12                      | 700252.32                    |
| Netherlands        | 2011 | 4     | 0.12                      | 526519.19                    |
| Netherlands        | 2011 | 5     | 0.15                      | 745877.10                    |
| Netherlands        | 2011 | 6     | 0.13                      | 744168.98                    |
| Netherlands        | 2011 | 7     | 0.15                      | 699630.13                    |
| Netherlands        | 2011 | 8     | 0.15                      | 717724.11                    |
| Netherlands        | 2011 | 9     | 0.12                      | 1037198.70                   |
| Netherlands        | 2011 | 10    | 0.11                      | 1128935.16                   |
| Netherlands        | 2011 | 11    | 0.15                      | 1461242.20                   |
| Netherlands        | 2011 | 12    | 0.11                      | 616139.70                    |
| Norway             | 2010 | 12    | 0.06                      | 781088.62                    |
| Norway             | 2011 | 1     | 0.07                      | 672289.31                    |
| Norway             | 2011 | 2     | 0.10                      | 510405.32                    |
| Norway             | 2011 | 3     | 0.10                      | 700252.32                    |
| Norway             | 2011 | 4     | 0.09                      | 526519.19                    |
| Norway             | 2011 | 5     | 0.08                      | 745877.10                    |
| Norway             | 2011 | 6     | 0.07                      | 744168.98                    |
| Norway             | 2011 | 7     | 0.07                      | 699630.13                    |
| Norway             | 2011 | 8     | 0.07                      | 717724.11                    |
| Norway             | 2011 | 9     | 0.07                      | 1037198.70                   |
| Norway             | 2011 | 10    | 0.06                      | 1128935.16                   |
| Norway             | 2011 | 11    | 0.07                      | 1461242.20                   |
| Norway             | 2011 | 12    | 0.05                      | 616139.70                    |
| Portugal           | 2010 | 12    | 0.12                      | 781088.62                    |
| Portugal           | 2011 | 1     | 0.12                      | 672289.31                    |
| Portugal           | 2011 | 2     | 0.10                      | 510405.32                    |
| Portugal           | 2011 | 3     | 0.11                      | 700252.32                    |
| Portugal           | 2011 | 4     | 0.12                      | 526519.19                    |
| Portugal           | 2011 | 5     | 0.12                      | 745877.10                    |
| Portugal           | 2011 | 6     | 0.11                      | 744168.98                    |
| Portugal           | 2011 | 7     | 0.12                      | 699630.13                    |
| Portugal           | 2011 | 8     | 0.12                      | 717724.11                    |
| Portugal           | 2011 | 9     | 0.11                      | 1037198.70                   |
| Portugal           | 2011 | 10    | 0.12                      | 1128935.16                   |
| Portugal           | 2011 | 11    | 0.13                      | 1461242.20                   |
| Portugal           | 2011 | 12    | 0.12                      | 616139.70                    |
| Slovakia           | 2010 | 12    | 0.04                      | 781088.62                    |
| Slovakia           | 2011 | 1     | 0.02                      | 672289.31                    |
| Slovakia           | 2011 | 2     | 0.03                      | 510405.32                    |
| Slovakia           | 2011 | 3     | 0.06                      | 700252.32                    |
| Slovakia           | 2011 | 4     | 0.05                      | 526519.19                    |
| Slovakia           | 2011 | 5     | 0.04                      | 745877.10                    |
| Slovakia           | 2011 | 6     | 0.03                      | 744168.98                    |
| Slovakia           | 2011 | 7     | 0.06                      | 699630.13                    |
| Slovakia           | 2011 | 8     | 0.06                      | 717724.11                    |
| Slovakia           | 2011 | 9     | 0.05                      | 1037198.70                   |
| Slovakia           | 2011 | 10    | 0.07                      | 1128935.16                   |
| Slovakia           | 2011 | 11    | 0.03                      | 1461242.20                   |
| Slovakia           | 2011 | 12    | 0.04                      | 616139.70                    |
| Slovenia           | 2010 | 12    | 0.07                      | 781088.62                    |
| Slovenia           | 2011 | 1     | 0.06                      | 672289.31                    |
| Slovenia           | 2011 | 2     | 0.07                      | 510405.32                    |
| Slovenia           | 2011 | 3     | 0.09                      | 700252.32                    |
| Slovenia           | 2011 | 4     | 0.09                      | 526519.19                    |
| Slovenia           | 2011 | 5     | 0.09                      | 745877.10                    |
| Slovenia           | 2011 | 6     | 0.10                      | 744168.98                    |
| Slovenia           | 2011 | 7     | 0.10                      | 699630.13                    |
| Slovenia           | 2011 | 8     | 0.10                      | 717724.11                    |
| Slovenia           | 2011 | 9     | 0.11                      | 1037198.70                   |
| Slovenia           | 2011 | 10    | 0.11                      | 1128935.16                   |
| Slovenia           | 2011 | 11    | 0.08                      | 1461242.20                   |
| Slovenia           | 2011 | 12    | 0.08                      | 616139.70                    |
| Spain              | 2010 | 12    | 0.06                      | 781088.62                    |
| Spain              | 2011 | 1     | 0.07                      | 672289.31                    |
| Spain              | 2011 | 2     | 0.08                      | 510405.32                    |
| Spain              | 2011 | 3     | 0.08                      | 700252.32                    |
| Spain              | 2011 | 4     | 0.08                      | 526519.19                    |
| Spain              | 2011 | 5     | 0.08                      | 745877.10                    |
| Spain              | 2011 | 6     | 0.08                      | 744168.98                    |
| Spain              | 2011 | 7     | 0.08                      | 699630.13                    |
| Spain              | 2011 | 8     | 0.08                      | 717724.11                    |
| Spain              | 2011 | 9     | 0.07                      | 1037198.70                   |
| Spain              | 2011 | 10    | 0.07                      | 1128935.16                   |
| Spain              | 2011 | 11    | 0.06                      | 1461242.20                   |
| Spain              | 2011 | 12    | 0.06                      | 616139.70                    |
| Sweden             | 2010 | 12    | 0.21                      | 781088.62                    |
| Sweden             | 2011 | 1     | 0.19                      | 672289.31                    |
| Sweden             | 2011 | 2     | 0.17                      | 510405.32                    |
| Sweden             | 2011 | 3     | 0.20                      | 700252.32                    |
| Sweden             | 2011 | 4     | 0.18                      | 526519.19                    |
| Sweden             | 2011 | 5     | 0.19                      | 745877.10                    |
| Sweden             | 2011 | 6     | 0.20                      | 744168.98                    |
| Sweden             | 2011 | 7     | 0.19                      | 699630.13                    |
| Sweden             | 2011 | 8     | 0.17                      | 717724.11                    |
| Sweden             | 2011 | 9     | 0.18                      | 1037198.70                   |
| Sweden             | 2011 | 10    | 0.21                      | 1128935.16                   |
| Sweden             | 2011 | 11    | 0.19                      | 1461242.20                   |
| Sweden             | 2011 | 12    | 0.21                      | 616139.70                    |
| Switzerland        | 2010 | 12    | 0.28                      | 781088.62                    |
| Switzerland        | 2011 | 1     | 0.22                      | 672289.31                    |
| Switzerland        | 2011 | 2     | 0.24                      | 510405.32                    |
| Switzerland        | 2011 | 3     | 0.27                      | 700252.32                    |
| Switzerland        | 2011 | 4     | 0.29                      | 526519.19                    |
| Switzerland        | 2011 | 5     | 0.27                      | 745877.10                    |
| Switzerland        | 2011 | 6     | 0.24                      | 744168.98                    |
| Switzerland        | 2011 | 7     | 0.22                      | 699630.13                    |
| Switzerland        | 2011 | 8     | 0.23                      | 717724.11                    |
| Switzerland        | 2011 | 9     | 0.23                      | 1037198.70                   |
| Switzerland        | 2011 | 10    | 0.21                      | 1128935.16                   |
| Switzerland        | 2011 | 11    | 0.22                      | 1461242.20                   |
| Switzerland        | 2011 | 12    | 0.19                      | 616139.70                    |


#### 5.) Finding the Total Revenue Generated by each country through the dataset's duration and calculating the country's contribution percentage to total revenue.

```sql
SELECT 
    Country, 
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
    ROUND((SUM(Quantity * UnitPrice) / (SELECT SUM(Quantity * UnitPrice) FROM transactions WHERE Quantity > 0 AND StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT'))) * 100, 2) AS revenue_percentage
FROM 
    transactions
WHERE 
    Quantity > 0 # omit refunds/defective goods/lost goods
    AND StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
GROUP BY 
    Country
ORDER BY 
    SUM(Quantity * UnitPrice) DESC;
```    

| Country                | Total Revenue | Revenue Percentage |
|------------------------|---------------|--------------------|
| United Kingdom         | 8,773,953.11  | 84.8%              |
| Netherlands            | 283,889.34    | 2.74%              |
| EIRE                   | 283,453.96    | 2.74%              |
| Germany                | 207,866.14    | 2.01%              |
| France                 | 194,261.11    | 1.88%              |
| Australia              | 138,171.31    | 1.34%              |
| Spain                  | 55,725.11     | 0.54%              |
| Switzerland            | 53,087.90     | 0.51%              |
| Japan                  | 37,416.37     | 0.36%              |
| Belgium                | 36,927.34     | 0.36%              |
| Sweden                 | 36,869.33     | 0.36%              |
| Norway                 | 33,294.94     | 0.32%              |
| Portugal               | 31,239.10     | 0.30%              |
| Singapore              | 21,279.29     | 0.21%              |
| Channel Islands        | 20,450.44     | 0.20%              |
| Finland                | 18,896.08     | 0.18%              |
| Denmark                | 18,211.34     | 0.18%              |
| Italy                  | 15,820.24     | 0.15%              |
| Hong Kong              | 15,516.80     | 0.15%              |
| Cyprus                 | 13,575.38     | 0.13%              |
| Austria                | 8,742.68      | 0.08%              |
| Israel                 | 8,135.26      | 0.08%              |
| Poland                 | 6,974.65      | 0.07%              |
| Unspecified            | 4,749.79      | 0.05%              |
| Greece                 | 4,425.52      | 0.04%              |
| Iceland                | 4,310.00      | 0.04%              |
| USA                    | 3,580.39      | 0.03%              |
| Canada                 | 3,115.44      | 0.03%              |
| Malta                  | 2,070.59      | 0.02%              |
| United Arab Emirates   | 1,864.78      | 0.02%              |
| Lebanon                | 1,693.88      | 0.02%              |
| Lithuania              | 1,661.06      | 0.02%              |
| European Community     | 1,159.25      | 0.01%              |
| Brazil                 | 1,143.60      | 0.01%              |
| RSA                    | 1,002.31      | 0.01%              |
| Czech Republic         | 786.74        | 0.01%              |
| Bahrain                | 754.14        | 0.01%              |
| Saudi Arabia           | 145.92        | 0.00%              |


### Querying Seasonality

#### 6.) Find the Revenue Generated per Season in addition to the percentage of total revenue the season captures.

```sql
SELECT 
    CASE
        WHEN (YEAR(InvoiceDate) = 2010) THEN 'Winter'
        WHEN (MONTH(InvoiceDate) = 3 AND DAY(InvoiceDate) >= 20) OR MONTH(InvoiceDate) IN (4, 5) OR (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) <= 20) THEN 'Spring'
        WHEN (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) >= 21) OR MONTH(InvoiceDate) IN (7, 8) OR (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) <= 22) THEN 'Summer'
        WHEN (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) >= 23) OR MONTH(InvoiceDate) IN (10, 11) OR (MONTH(InvoiceDate) = 12 AND DAY(InvoiceDate) <= 20) THEN 'Autumn'
        ELSE 'Winter'
    END AS Season,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Revenue,
    ROUND((SUM(Quantity * UnitPrice) / (SELECT SUM(Quantity * UnitPrice) FROM transactions WHERE Quantity > 0 
    AND StockCode NOT IN ('M', 'AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'D', 'DOT'))) * 100, 2) AS Percentage_of_Total_Revenue
FROM transactions
WHERE Quantity > 0 AND StockCode NOT IN ('M', 'AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'D', 'DOT')
GROUP BY 
    CASE
        WHEN (YEAR(InvoiceDate) = 2010) THEN 'Winter'
        WHEN (MONTH(InvoiceDate) = 3 AND DAY(InvoiceDate) >= 20) OR MONTH(InvoiceDate) IN (4, 5) OR (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) <= 20) THEN 'Spring'
        WHEN (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) >= 21) OR MONTH(InvoiceDate) IN (7, 8) OR (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) <= 22) THEN 'Summer'
        WHEN (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) >= 23) OR MONTH(InvoiceDate) IN (10, 11) OR (MONTH(InvoiceDate) = 12 AND DAY(InvoiceDate) <= 20) THEN 'Autumn'
        ELSE 'Winter'
    END
ORDER BY 
    Season;
```

| Season | Total Revenue | Percentage of Total Revenue |
|--------|---------------|------------------------------|
| Autumn | 3,447,778.95  | 33.58%                       |
| Spring | 2,108,695.44  | 20.54%                       |
| Summer | 2,381,840.31  | 23.20%                       |
| Winter | 2,329,793.11  | 22.69%                       |


#### 7.) Displaying the Top 10 Most Sold Products per Season.

```sql
WITH RankedProducts AS (
    SELECT 
        StockCode,
        `Description`,
        CASE
            WHEN (MONTH(InvoiceDate) = 3 AND DAY(InvoiceDate) >= 20) OR (MONTH(InvoiceDate) = 4 OR MONTH(InvoiceDate) = 5) OR (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) < 21) THEN 'Spring'
            WHEN (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) >= 21) OR (MONTH(InvoiceDate) IN (7, 8)) OR (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) <= 22) THEN 'Summer'
            WHEN (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) >= 23) OR (MONTH(InvoiceDate) IN (10, 11)) OR (MONTH(InvoiceDate) = 12 AND DAY(InvoiceDate) <= 20) THEN 'Autumn'
            ELSE 'Winter'
        END AS Season,
        COUNT(*) AS SalesCount,
        ROW_NUMBER() OVER (PARTITION BY 
                                CASE
                                    WHEN (MONTH(InvoiceDate) = 3 AND DAY(InvoiceDate) >= 20) OR (MONTH(InvoiceDate) = 4 OR MONTH(InvoiceDate) = 5) OR (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) < 21) THEN 'Spring'
                                    WHEN (MONTH(InvoiceDate) = 6 AND DAY(InvoiceDate) >= 21) OR (MONTH(InvoiceDate) IN (7, 8)) OR (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) <= 22) THEN 'Summer'
                                    WHEN (MONTH(InvoiceDate) = 9 AND DAY(InvoiceDate) >= 23) OR (MONTH(InvoiceDate) IN (10, 11)) OR (MONTH(InvoiceDate) = 12 AND DAY(InvoiceDate) <= 20) THEN 'Autumn'
                                    ELSE 'Winter'
                                END 
                          ORDER BY COUNT(*) DESC) AS RankNumber
    FROM 
        transactions
    GROUP BY 
        StockCode, `Description`, Season
)
SELECT 
    StockCode, `Description`, Season, SalesCount
FROM 
    RankedProducts
WHERE 
    RankNumber <= 10
ORDER BY 
    Season, RankNumber;
```

| StockCode | Description                                 | Season | SalesCount |
|-----------|---------------------------------------------|--------|------------|
| 22086     | PAPER CHAIN KIT 50'S CHRISTMAS              | Autumn | 991        |
| 85123A    | WHITE HANGING HEART T-LIGHT HOLDER          | Autumn | 793        |
| 23084     | RABBIT NIGHT LIGHT                          | Autumn | 747        |
| 22910     | PAPER CHAIN KIT VINTAGE CHRISTMAS           | Autumn | 707        |
| 85099B    | JUMBO BAG RED RETROSPOT                     | Autumn | 691        |
| 22423     | REGENCY CAKESTAND 3 TIER                    | Autumn | 687        |
| 23355     | HOT WATER BOTTLE KEEP CALM                  | Autumn | 659        |
| 22112     | CHOCOLATE HOT WATER BOTTLE                  | Autumn | 598        |
| 22865     | HAND WARMER OWL DESIGN                      | Autumn | 580        |
| 22111     | SCOTTIE DOG HOT WATER BOTTLE                | Autumn | 563        |
| 47566     | PARTY BUNTING                               | Spring | 678        |
| 85123A    | WHITE HANGING HEART T-LIGHT HOLDER          | Spring | 614        |
| 22423     | REGENCY CAKESTAND 3 TIER                    | Spring | 605        |
| 85099B    | JUMBO BAG RED RETROSPOT                     | Spring | 536        |
| 20725     | LUNCH BAG RED RETROSPOT                     | Spring | 436        |
| 21212     | PACK OF 72 RETROSPOT CAKE CASES             | Spring | 389        |
| 84879     | ASSORTED COLOUR BIRD ORNAMENT               | Spring | 373        |
| 22993     | SET OF 4 PANTRY JELLY MOULDS                | Spring | 370        |
| 22383     | LUNCH BAG SUKI DESIGN                       | Spring | 355        |
| 23206     | LUNCH BAG APPLE DESIGN                      | Spring | 355        |
| 85099B    | JUMBO BAG RED RETROSPOT                     | Summer | 584        |
| 23298     | SPOTTY BUNTING                              | Summer | 515        |
| 47566     | PARTY BUNTING                               | Summer | 506        |
| 85123A    | WHITE HANGING HEART T-LIGHT HOLDER          | Summer | 506        |
| 20725     | LUNCH BAG RED RETROSPOT                     | Summer | 477        |
| 22423     | REGENCY CAKESTAND 3 TIER                    | Summer | 471        |
| 23245     | SET OF 3 REGENCY CAKE TINS                  | Summer | 459        |
| 23206     | LUNCH BAG APPLE DESIGN                      | Summer | 422        |
| 22383     | LUNCH BAG SUKI DESIGN                       | Summer | 422        |
| 20727     | LUNCH BAG BLACK SKULL                       | Summer | 411        |
| 85123A    | WHITE HANGING HEART T-LIGHT HOLDER          | Winter | 456        |
| 22720     | SET OF 3 CAKE TINS PANTRY DESIGN            | Winter | 456        |
| 22423     | REGENCY CAKESTAND 3 TIER                    | Winter | 437        |
| 85099B    | JUMBO BAG RED RETROSPOT                     | Winter | 348        |
| 22469     | HEART OF WICKER SMALL                      | Winter | 322        |
| 22722     | SET OF 6 SPICE TINS PANTRY DESIGN           | Winter | 302        |
| 22960     | JAM MAKING SET WITH JARS                    | Winter | 293        |
| 22457     | NATURAL SLATE HEART CHALKBOARD              | Winter | 286        |
| 22961     | JAM MAKING SET PRINTED                      | Winter | 264        |
| 20725     | LUNCH BAG RED RETROSPOT                     | Winter | 264        |


### Querying Customer Segmentation

#### 8.) Finding the 10 Most Profitable Customers. (Profit = Revenue - Refunds - Discounts)

```sql
SELECT CustomerID, ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue_Generated
FROM transactions
WHERE CustomerID != '' AND StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'DOT') # omit miscellaneous transactions but include refunds and discounts
GROUP BY CustomerID
ORDER BY Revenue_Generated DESC
LIMIT 10;
```

| CustomerID | Revenue_Generated |
|------------|-------------------|
| 14646      | 278,466.02        |
| 18102      | 256,438.49        |
| 17450      | 188,420.57        |
| 14911      | 132,572.62        |
| 12415      | 123,638.18        |
| 14156      | 113,384.14        |
| 17511      | 88,127.55         |
| 16684      | 65,892.08         |
| 13694      | 62,653.10         |
| 15311      | 59,419.34         |


#### 9.) Finding the Top 10 Customers with the Highest Average Order Amount.

```sql
SELECT CustomerID, ROUND(AVG(Quantity * UnitPrice), 2) AS average_order_value
FROM transactions
WHERE CustomerID != '' AND StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'DOT') AND Quantity > 0 # omit miscellaneous transactions and refunds but include discounts
GROUP BY CustomerID
ORDER BY average_order_value DESC
LIMIT 10;
```

| CustomerID | Average_Order_Value |
|------------|----------------------|
| 12346      | 77,183.60            |
| 16446      | 56,157.50            |
| 15098      | 13,305.50            |
| 15749      | 4,453.43             |
| 15195      | 3,861.00             |
| 13135      | 3,096.00             |
| 17846      | 2,033.10             |
| 18087      | 2,027.86             |
| 16532      | 1,687.20             |
| 16000      | 1,377.08             |


#### 10.) Find the Top 10 Repeat Customers with the most orders placed.

```sql
SELECT CustomerID, Country, COUNT(DISTINCT InvoiceNo) AS orders_placed
FROM transactions
WHERE CustomerID != '' AND StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'D', 'DOT') AND Quantity > 0 # omit rows with missing CustomerID info, omit miscellaneous transactions & refunds
GROUP BY CustomerID, Country
ORDER BY orders_placed DESC
LIMIT 10;
```

| CustomerID | Country         | Orders_Placed |
|------------|-----------------|---------------|
| 12748      | United Kingdom  | 210           |
| 14911      | EIRE            | 201           |
| 17841      | United Kingdom  | 124           |
| 13089      | United Kingdom  | 97            |
| 15311      | United Kingdom  | 91            |
| 14606      | United Kingdom  | 91            |
| 12971      | United Kingdom  | 86            |
| 14646      | Netherlands     | 73            |
| 16029      | United Kingdom  | 62            |
| 13408      | United Kingdom  | 62            |


#### 11.) Displaying the Top 10 Countries with the Highest Average Order Value.

```sql
SELECT Country, ROUND(AVG(Quantity * UnitPrice), 2) AS average_order_value
FROM transactions
WHERE StockCode NOT IN ('AMAZONFEE', 'POST', 'BANK CHARGES' ,'CRUK', 'S', 'DOT') AND Quantity > 0 # omit miscellaneous transactions and refunds but include discounts
GROUP BY Country
ORDER BY average_order_value DESC
LIMIT 10;
```
| Country      | Average_Order_Value |
|--------------|----------------------|
| Netherlands  | 122.05               |
| Australia    | 116.7                |
| Japan        | 116.56               |
| Singapore    | 95.85                |
| Sweden       | 85.94                |
| Hong Kong    | 55.02                |
| Denmark      | 49.62                |
| Lithuania    | 47.46                |
| Bahrain      | 41.9                 |
| Lebanon      | 37.64                |


#### 12.) Projecting the Customer Lifetime Value for every repeat customer that has been a customer for longer than 30 days. Displaying the customers with the largest customer lifetime value from the top-down.

```sql
-- Customer Lifetime Value: CLV = Average Order Value x Purchase Frequency x Average Length of Customer Relationship 
SELECT 
    transactions.CustomerID,
    transactions.Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Revenue,
    ROUND(SUM(Quantity * UnitPrice) / Num_Purchases,
            2) AS Average_Order_Value,
    Num_Purchases,
    DATEDIFF(MAX(InvoiceDate), MIN(InvoiceDate)) AS Duration_of_Relationship,
    (365 / (DATEDIFF(MAX(InvoiceDate), MIN(InvoiceDate)))) AS conversion_factor,
    ROUND(Num_Purchases * (365 / DATEDIFF(MAX(InvoiceDate), MIN(InvoiceDate)))) AS Projected_Number_of_Purchases_Per_Year,
    ROUND(1 / ((SELECT 
                    COUNT(*) AS NumberOfConsistentCustomers
                FROM
                    (SELECT 
                        CustomerID, COUNT(DISTINCT InvoiceNo) AS NumInvoices
                    FROM
                        transactions
                    WHERE
                        CustomerID != ''
                            AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
                            AND Quantity > 0
                    GROUP BY CustomerID
                    HAVING NumInvoices > 1) AS Subquery) / ((SELECT 
                    COUNT(*) AS NumberOfConsistentCustomers
                FROM
                    (SELECT 
                        CustomerID, COUNT(DISTINCT InvoiceNo) AS NumInvoices
                    FROM
                        transactions
                    WHERE
                        CustomerID != ''
                            AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
                            AND Quantity > 0
                    GROUP BY CustomerID
                    HAVING COUNT(DISTINCT InvoiceNo) > 1) AS Subquery) + (SELECT 
                    COUNT(*) AS NumberOfOneTimeCustomers
                FROM
                    (SELECT 
                        CustomerID, COUNT(DISTINCT InvoiceNo) AS NumInvoices
                    FROM
                        transactions
                    WHERE
                        CustomerID != ''
                            AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
                            AND Quantity > 0
                    GROUP BY CustomerID
                    HAVING COUNT(DISTINCT InvoiceNo) = 1) AS Subquery))),
            2) AS Average_Customer_Lifespan,
    ROUND((SUM(Quantity * UnitPrice) / Num_Purchases) * (ROUND(Num_Purchases * (365 / DATEDIFF(MAX(InvoiceDate), MIN(InvoiceDate))))) * (ROUND(1 / ((SELECT 
                            COUNT(*) AS NumberOfConsistentCustomers
                        FROM
                            (SELECT 
                                CustomerID, COUNT(DISTINCT InvoiceNo) AS NumInvoices
                            FROM
                                transactions
                            WHERE
                                CustomerID != ''
                                    AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
                                    AND Quantity > 0
                            GROUP BY CustomerID
                            HAVING NumInvoices > 1) AS Subquery) / ((SELECT 
                            COUNT(*) AS NumberOfConsistentCustomers
                        FROM
                            (SELECT 
                                CustomerID, COUNT(DISTINCT InvoiceNo) AS NumInvoices
                            FROM
                                transactions
                            WHERE
                                CustomerID != ''
                                    AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
                                    AND Quantity > 0
                            GROUP BY CustomerID
                            HAVING COUNT(DISTINCT InvoiceNo) > 1) AS Subquery) + (SELECT 
                            COUNT(*) AS NumberOfOneTimeCustomers
                        FROM
                            (SELECT 
                                CustomerID, COUNT(DISTINCT InvoiceNo) AS NumInvoices
                            FROM
                                transactions
                            WHERE
                                CustomerID != ''
                                    AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
                                    AND Quantity > 0
                            GROUP BY CustomerID
                            HAVING COUNT(DISTINCT InvoiceNo) = 1) AS Subquery))),
                    2)),
            2) AS Customer_Lifetime_Value
FROM
    (SELECT 
        CustomerID, COUNT(DISTINCT InvoiceNo) AS Num_Purchases
    FROM
        transactions
    WHERE
        CustomerID != ''
            AND StockCode NOT IN ('AMAZONFEE' , 'POST', 'BANK CHARGES', 'CRUK', 'S', 'D', 'DOT')
            AND Quantity > 0
    GROUP BY CustomerID) AS Subquery
        JOIN
    transactions ON Subquery.CustomerID = transactions.CustomerID
WHERE
    transactions.CustomerID != ''
        AND StockCode NOT IN ('AMAZONFEE' , 'POST',
        'BANK CHARGES',
        'CRUK',
        'S',
        'DOT')
GROUP BY CustomerID , Country
HAVING Num_Purchases > 1
    AND Duration_of_Relationship > 30
ORDER BY Customer_Lifetime_Value DESC
LIMIT 10;
```

| CustomerID | Country         | Total_Revenue | Average_Order_Value | Num_Purchases | Duration_of_Relationship | Conversion_Factor | Projected_Number_of_Purchases_Per_Year | Average_Customer_Lifespan | Customer_Lifetime_Value |
|------------|-----------------|---------------|----------------------|---------------|---------------------------|-------------------|---------------------------------------|---------------------------|--------------------------|
| 14646      | Netherlands     | 278466.02     | 3814.6               | 73            | 353                       | 1.034             | 75                                    | 1.53                      | 437725.7                 |
| 18102      | United Kingdom  | 256438.49     | 4273.97              | 60            | 367                       | 0.9946            | 60                                    | 1.53                      | 392350.89                |
| 14096      | United Kingdom  | 53147.98      | 3126.35              | 17            | 97                        | 3.7629            | 64                                    | 1.53                      | 306132.36                |
| 17450      | United Kingdom  | 188420.57     | 4096.1               | 46            | 359                       | 1.0167            | 47                                    | 1.53                      | 294550.5                 |
| 12415      | Australia       | 123638.18     | 6181.91              | 20            | 313                       | 1.1661            | 23                                    | 1.53                      | 217541.38                |
| 14911      | EIRE            | 132572.62     | 659.57               | 201           | 372                       | 0.9812            | 197                                   | 1.53                      | 198799.57                |
| 14156      | EIRE            | 113384.14     | 2061.53              | 55            | 363                       | 1.0055            | 55                                    | 1.53                      | 173477.73                |
| 17511      | United Kingdom  | 88127.55      | 2842.82              | 31            | 371                       | 0.9838            | 30                                    | 1.53                      | 130485.63                |
| 15749      | United Kingdom  | 21535.9       | 7178.63              | 3             | 97                        | 3.7629            | 11                                    | 1.53                      | 120816.4                 |
| 16684      | United Kingdom  | 65892.08      | 2353.29              | 28            | 354                       | 1.0311            | 29                                    | 1.53                      | 104415.41                |


## Step 3. Tableau Dashboard Development

I exported some results tables from the aforementioned queries and was able to create various visualizations that make the results more readily understandable.

[Dashboard Link](https://public.tableau.com/app/profile/robinson.kao/viz/OnlineRetailSalesDashboard_17141246193480/Dashboard1)
