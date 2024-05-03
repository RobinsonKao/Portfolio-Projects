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

- [Dataset Used](#dataset-used)
- [Analytic Techniques and Models](#analytic-techniques-and-models)
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

C. Statsmodel API: I utilized the OLS function of the Statsmodel API to create a multivariable linear regression model. Because I was working with such a large dataset with many different features (30+), this helped me analyze everything in an organized fashion, ranging from the coefficients to the p-values, to the R² values. I later used my OLS models to predict the test sets as well as salaries for our own randomized data scientists.

D. Out of Sample R²: I implemented the OSR2 function to test whether the model has any sort of out-of-sample predictability.

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

I visualized the dependent variable, "salary_in_usd," on the first plot, revealing a right-skewed distribution. 

![Plot 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/a75be68c-96d1-42a9-9258-590a39510ff2)

Subsequently, I transformed this variable by applying the logarithm function, resulting in a more favorable distribution, as depicted in the following-side plot. 

![Plot 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/e4b19a33-238f-4a15-aa9e-90ca43300003)

However, the most optimal distribution was achieved by applying the cube root function to "salary_in_usd," as illustrated in the bottom plot, demonstrating the most improved distribution among the three transformations.

![Plot 3](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/3b30b56d-ea32-455b-8087-8c4746aa6e93)

## Step 4: Model Training

### Split the dataset into training and test sets and then use Statsmodel functions to perform linear regression analysis to the predict the cube root of the salary ('cbrt_salary_in_usd') using the other features in the DataFrame "df_train". It then prints and displays a summary of the regression results.

![split](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/841f0458-4a9a-4424-8b1d-3c6d4e265ce9)

### Define OSR²

![OSR2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/60e0095b-6b1a-4457-86e1-cd73e4a34d70)

### Feature Selection using VIF to identify good features

![VIF](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/e435cdd7-ab65-41c3-b549-b0b93125d48c)

### Feature Selection using p-Values to elimintate features (features with p-values above 0.5)

![Pvalue](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/5eb95d7b-c1da-4c79-8f80-56dc643db7db)

### Reassess Model with the retained features

![Reassess](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/f03bf567-5a26-4433-94b8-fac5ebba3453)
![new osr2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/e1c9a89c-79d0-4db7-93e9-5dcd649e139e)

### Removing 0 coefficient features (feature has no impact on the prediction) and NaN p-value features (removing features where the p-value associated with their coefficient estimate is NaN (not a number). Then reassess the fit of the model.

![Remove 0](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/cf8f3070-f5cb-4215-9416-442c9879f14c)

## Step 5: Model Evaluation

### Forecast the test set and contrast the outcomes. "y_pred" represents the model's predictions for the target variable in the test dataset, and interpreting these results involves evaluating the accuracy and reliability of the predictions compared to the actual values.

![Predicting test set](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/f9601939-b459-4b3b-b558-fa3e82b04540)

### Forecast randomized entries of my own.

![Predict my own](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/ed8da3b9-79df-4e47-a11e-4f7090d4e44b)
![predict my own part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/2ddb83e0-17e3-4fa8-9801-b218f3d58587)
![predict my own part 3](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/0d9bba9e-8a8f-44a0-8de7-ff13ee97ce5c)
![predict my own part 4](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/86e83b33-8b5d-4765-8db6-2fcf2e079fb2)

### Generate salary predictions for 200 randomly selected data scientists.

![predict my own part 5](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/41304377-96b7-4cea-b8fc-48cd85aaeac8)

### Interpreting the results: 

Initially, I didn't take the cube root of my prediction variable, leading to poor results. The OSR2 after feature selection was -1.3847 (with a R-squared of 0.816 and Adj. R-squared of 0.792). This initial model predicted negative salaries in the proof-of-concept randomized DataFrame, which didn't align with the problem's context. Therefore, I reevaluated my dataset processing. After visualizing the log(salary_in_usd) distribution, I created a model that significantly outperformed the initial one. The updated model's OSR2 after feature selection was approximately 0.5810 (with a R-squared of 0.920 and Adj. R-squared of 0.903). Additionally, the log model didn't predict negative log(salary_in_usd) values for the proof-of-concept dataset.

Final & Best Model: For my cube root model, after feature selection, it had the best OSR² value of 0.8035 (R² of 0.966 and Adj. R² of 0.959) and doesn't predict negative values from our proof-of-concept dataset as well. Overall, the results of the cube root model can be seen below in the next section's plots. 

### How confident am I in my results?

Originally, I was not confident at all in my results. Due to predicting negative salaries, a low negative OSR² value (<1), and a lower R² (~08), I felt like there was room for improvement and there may not be enough applicability of my model in a real world context. However, after performing the log transformation, later going with the cube root transformation, and analyzing the results explained in part II (higher R², OSR², and all positive salaries), I felt a lot more confident in them and was excited to see that my model may have potential when applied to real world data, as indicated in my predictions on my own testing data with lower residuals this time. The improvement seen from the progression of my model implementations provides a great sense of confidence in my final (cube root) model.

### This code generates a scatter plot to visualize the relationship between predicted salaries (y_pred) and actual salaries (df_test_y_actual) for a dataset of data scientists. Overall, this code visually compares the predicted and actual salaries of data scientists using a scatter plot and adds a line representing perfect prediction. It helps to assess the accuracy and performance of the salary prediction model.

![predict my own part 6](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/1c289b3b-0395-49d3-bdcd-da61dca85a8c)

### This code calculates the residuals, which are the differences between the actual salaries (df_test_y_actual) and the predicted salaries (y_pred) for a dataset of data scientists. Overall, this code visually examines the residuals (errors) of the salary prediction model by plotting them against the predicted salaries. It helps in assessing the model's performance and identifying any patterns or trends in the errors.

![predict my own part 7](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/fbfcab7e-99a0-40d7-8ecf-370fe580e11c)





