# 💵 Data Science Worldwide Salary Prediction Project

## My Jupyter Notebook

You can view my Jupyter Notebook: [here](https://nbviewer.org/github/RobinsonKao/Portfolio-Projects/blob/main/Data%20Science%20Salaries%20Project/Data_Science_Salary_Prediction.ipynb)

## Objective

This project aims to develop a global salary prediction model for data science roles using machine learning. By analyzing factors like experience level, geographic location, employment type, and company location, the model offers insights into compensation and areas for improvement. As an aspiring data scientist, I embarked on this project to uncover key predictors for success in the dynamic field of data science. Recognizing the industry's evolution and the importance of financial stability, I explored the dataset and models to identify career-enhancing indicators. Below are the steps I followed:

1. Data Acquisition: Obtain dataset from Kaggle, prioritizing more recent data.
2. Data Processing: Utilize Python, Pandas, and Numpy to clean data, including dropping unnecessary columns and encoding categorical variables.
3. Variable Transformation: Apply mathematical transformations to the "salary_in_usd" variable to improve its distribution for analysis.
4. Model Training: Develop a machine learning model using the processed data.
5. Evaluation: Plot y_predicted vs y_actual and y_predicted vs residuals to assess model performance.

The sections below will explain additional details on the technologies and dataset utilized.

## Table of Content

- Dataset Used
- Analytic Techniques and Models
- Step 1: Data Acquisition
- Step 2: Data Processing
- Step 3: Variable Transformation
- Step 4: Model Training
- Step 5: Evaluation

## Dataset Used

This project uses a Data Science Jobs Salaries Dataset from Kaggle which contains information on salaries for various data science roles, including the year in which the salary was paid, experience level, employment type, job title, salary amount, salary currency, converted salary in USD, employee residence country, remote work ratio, company location, and company size.

1.) Year: Indicates the year in which the salary was paid, with two possible values: "2020" for definitive amounts from the past and "2021e" for estimated amounts, typically for the current year.

2.) Experience Level: Describes the experience level of the employee, categorized as Entry-level/Junior, Mid-level/Intermediate, Senior-level/Expert, or Executive-level/Director.

3.) Employment Type: Specifies the type of employment for the role, including Part-time, Full-time, Contract, or Freelance.

4.) Job Title: Identifies the specific role worked during the year.

5.) Salary: Represents the total gross salary amount paid.

6.) Salary Currency: Denotes the currency of the salary paid, using ISO 4217 currency codes.

7.) Salary in USD: Indicates the salary amount converted to USD, calculated using the FX rate divided by the average USD rate for the respective year.

8.) Employee Residence: Refers to the primary country of residence of the employee during the work year, using ISO 3166 country codes.

9.) Remote Work Ratio: Specifies the proportion of work done remotely, with possible values of 0 (no remote work), 50 (partially remote), or 100 (fully remote).

10.) Company Location: Represents the country of the employer's main office or contracting branch, using ISO 3166 country codes.

11.) Company Size: Indicates the average number of people that worked for the company during the year, categorized as small (less than 50 employees), medium (50 to 250 employees), or large (more than 250 employees).

Dataset Link: [Data Science Jobs Salaries](https://www.kaggle.com/datasets/saurabhshahane/data-science-jobs-salaries/data)

## Analytic Techniques and Models

The following technologies are used to build this project:

- Language: Python
- Extraction and transformation: Jupyter Notebook
- Libraries and Methods:

A. Pandas: Pandas was the bread and butter of the notebook for manipulation and analysis of the dataset. It was used to read in the dataset as a CSV, add and drop features, create dummy variables, and more.

B. Sklearn: I implemented quintessential machine learning tasks such as splitting the dataset into training and testing sets using scikit-learn's "train_test_split()". I aimed for a 70% training : 30% test split and was able to successfully accomplish that.

C. Statsmodel API: I utilized the OLS function of the Statsmodel API to create a multivariable linear regression model. Because I was working with such a large dataset with many different features (30+), this helped me analyze everything in an organized fashion, ranging from the coefficients to the p-values, to the R"^2" values. I later used my OLS models to predict the test sets as well as salaries for our own randomized data scientists.

D. Out of Sample R"^2": I implemented the OSR2 function to test whether the model has any sort of out-of-sample predictability.

E. Other minor libraries and functions (Numpy, Matplotlib, Seaborn): I also implemented a few other libraries and methods for minor tasks like data cleaning and generating visualization plots.

## Step 1: Data Acquistion

As mentioned earlier, this dataset was sourced from Kaggle and includes various categorical indicators. These indicators shed light on how they relate to a data scientist's salary. The dataset covers recent years, specifically 2020 and 2021, and includes data on different levels of experience, types of employment, job titles, current country of residence, remote work ratio, company location, and company size.

Below I import the CSV into Jupyter Notebook and get an initial look at each of the columns:

![Import CSV](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/a07aff1d-9469-4670-8087-9dc685ef0727)

## Step 2: Data Processing

I utilized .ipynb Colaboratory notebooks to write code for data cleaning. This data processing involved Python, Pandas, and Numpy. We employed Pandas to create dataframes and utilized its functions for code organization. Unnecessary columns were dropped, and categorical variables were one-hot encoded. Subsequently, we removed columns after employing dummy variables.

![Data Preprocessing Part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/5c67d2ea-b3da-41c6-a785-e236be621891)
![Data Preprocessing Part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/2870d9f0-03c3-4fc8-b004-f16adecc83ea)

## Step 3: Variable Transformation





