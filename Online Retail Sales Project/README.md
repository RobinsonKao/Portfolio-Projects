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

- Dataset Used
- Technologies
- Date Modeling
  - Step 1: Sourcing and Loading Data
  - Step 2: Querying
  - Step 3: Analytics
  - Step 4: Dashboard Development

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
- Raw Data (CSV): [Online Retail Data CSV]()

## Technologies

The following technologies are used to build this project:

- Language: SQL
- Extraction and transformation: MySQL, Excel
- Dashboard: Tableau

## Step 1. Loading the Data into MySQL

In this step, I instantiated a new database for the project and created a new table in MySQL to populate it with the CSV data.

![Instantiating New Database and New Table](http://url/to/img.png)


