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
- [Step 1: Sourcing and Loading Data](#step-1.-loading-the-data-into-mysql)
- [Step 2: Querying & Analytics](#step-2.-querying-and-analytics)
- [Step 3: Dashboard Development](#step-3.-tableau-dashboard-development)

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

![Creating Database and Table](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/e39fd12f-3ecb-42bf-ab37-2540bf521008)
)

Here I reformat the "InvoiceDate" variable from Varchar (what I instantiated its variable as when I created the table) to MySQL's built-in TimeStamp.

![Reformat TimeStamp Data](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/e120b408-1db8-42b8-b42b-f22d3a8bc857)


Displaying sample rows of the data to familiarize with each of the variables.

![Display Sample Data](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/1b0b14c7-5359-4a56-88fa-18e682b6d2b8)
![Displaying Sample Data Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/f8e9434f-9e66-4220-9158-01a04316080b)

## Step 2. Querying & Analytics

### Querying Revenue

1.) Finding the Total Revenue, Cost of Goods Sold, and Net Profit generated in the year-long duration of the dataset.

![Total Revenue, COGS, Net Profit Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/3f725488-ca9d-45d2-b92c-10bd87859b4b)
![Total Revenue, COGS, Net Profit Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/00c7c6a4-7bc0-47ae-93de-61216c8e468d)


2.) Finding the Month-to-Month Revenue generated in the year-long duration of the dataset.

![Month to Month Revenue Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/37da3c1f-673b-4737-8132-4afc0206dbfe)
![Month to Month Revenue Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/57e062cd-c484-4e9f-91e3-8ccdf6adf911)

3.) Displaying the Month-to-Month Revenue generated per country and cumulatively adding to their total accrued revenue.

![Month to Month Revenue by Country Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/4cafcf39-2502-4bc8-9ec9-b41998a181df)
![Month to Month Revenue by Country Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/4a86f3b4-f172-4ed2-b282-b6c132fe0dbc)

4.) Displaying the Month-to-Month Revenue generated per country the percentage of the month's total revenue captured by that country.

![Month to Month Revenue by Country Percentage Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/c153b2be-6329-4bce-b6f2-d75c8ddc6546)
![Month to Month Revenue by Country Percentage Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/e8bb51b3-0548-4e7f-8ed4-6915516d1467)

5.) Finding the Total Revenue Generated by each country through the dataset's duration and calculating the country's contribution percentage to total revenue.

![Total Revenue by Country Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/6ad1c2db-9e53-4e8c-8e6f-285acd1c9c48)
![Total Revenue by Country Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/4a979b6b-5623-47f5-93cb-2c063fd0699a)

### Querying Seasonality

6.) Find the Revenue Generated per Season in addition to the percentage of total revenue the season captures.

![Revenue per Season Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/f8a805b0-776d-4aba-9698-fcea70fb2db4)
![Revenue Per Season Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/9b45af44-fa47-4a44-aff3-6b56487e60bd)

7.) Displaying the Top 10 Most Sold Products per Season.

![Most Popular per Season Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/c943feb2-556b-4294-9777-2ee9e985f4e8)
![Most Popular per Season Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/ece7da35-95ee-441c-8683-f69f61981622)

### Querying Customer Segmentation

8.) Finding the 10 Most Profitable Customers. (Profit = Revenue - Refunds - Discounts)

![Top 10 Profitable Customers Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/40b68284-3973-42b1-8e71-f17c454310fc)
![Top 10 Profitable Customers Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/72cb4eb8-57d3-498e-b570-10827425e9f3)

9.) Finding the Top 10 Customers with the Highest Average Order Amount.

![10 Highest Average Order Values Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/0cc43965-24c2-41d5-a4c9-a5ca151cd5a9)
![10 Highest Average Order Values Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/4b57e611-92ca-43a3-8a11-dda708325721)

10.) Find the Top 10 Repeat Customers with the most orders placed.

![Repeat Customers Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/66daf57a-0132-4ddd-a395-dc25c627ab2c)
![Repeat Customers Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/2060b917-b495-430a-b4b4-e1069afe4015)

11.) Displaying the Top 10 Countries with the Highest Average Order Value.

![Highest Average Order Value by Country Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/68d940a1-f9e9-471b-8e8b-8925e4097a5c)
![Highest Average Order Value by Country Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/678d4ec9-02be-456a-b16d-616b0681bfea)

12.) Projecting the Customer Lifetime Value for every repeat customer that has been a customer for longer than 30 days. Displaying the customers with the largest customer lifetime value from the top-down.

![CLV Part 1 Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/265b02ab-3f13-4aad-a6a2-feb214ee9bb4)
![CLV Part 2 Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/221ae4b3-76be-4983-88db-fbd684c6e128)
![CLV Part 3  Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/65f6a5ed-811d-45f8-ab74-c4de39706557)
![CLV Part 4 Code](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/23a65e3b-1c2c-430b-bbe9-07095a1a0f16)
![CLV Results](https://github.com/RobinsonKao/SQL-Projects/assets/112150963/b9d09c5f-45af-4abc-8a19-be88c24dce3d)

## Step 3. Tableau Dashboard Development

I exported some results tables from the aforementioned queries and was able to create various visualizations that make the results more readily understandable.

[Dashboard Link](https://public.tableau.com/app/profile/robinson.kao/viz/OnlineRetailSalesDashboard_17141246193480/Dashboard1)
