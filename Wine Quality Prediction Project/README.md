# 🍷 Wine Quality Prediction Project

## My Jupyter Notebook

You can view my Jupyter Notebook: [here](https://nbviewer.org/github/RobinsonKao/Portfolio-Projects/blob/main/Wine%20Quality%20Prediction%20Project/Wine%20Quality.ipynb)

## Objective

The objective of this project was to develop and evaluate three machine learning models—Linear Regression, Logistic Regression, and Linear Discriminant Analysis—designed to predict wine quality. Below are the steps I followed:

1. Data Acquisition
2. Linear Regression Feature Selection & Training
3. Linear Regression Model Evaluation
4. Logistic Regression Feature Selection & Training
5. Logistic Regression Model Evalution
6. Linear Discriminant Analysis Training & Evaluation
7. ROC Curve & Overall Evaluation

The sections below will explain additional details on the technologies and dataset utilized.

## Table of Content

- [Dataset Used](#dataset-used)
- [Analytic Techniques and Models](#analytic-techniques-and-models)
- [Step 1: Data Acquisition](#step-1-data-acquisition)
- [Step 2: Linear Regression Feature Selection & Training](#step-2-linear-regression-feature-selection-and-training)
- [Step 3: Linear Regression Model Evaluation](#step-3-linear-regression-model-evaluation)
- [Step 4: Logistic Regression Model 1 Feature Selection & Training](#step-4-logistic-regression-model-1-feature-selection-and-training)
- [Step 5: Logistic Regression Model 1 Evaluation](#step-5-logistic-regression-model-1-evaluation)
- [Step 6: Logistic Regression Model 2 Feature Selection & Training](#step-6-logistic-regression-model-2-feature-selection-and-training)
- [Step 7: Logistic Regression Model 2 Evaluation](#step-7-logistic-regression-model-2-evaluation)
- [Step 8: Linear Discriminant Analysis Training & Evaluation](#step-8-linear-discriminant-analysis-training-and-evaluation)
- [Step 9: ROC Curve & Overall Evaluation](#step-9-roc-curve)

## Dataset Used

This project uses a dataset from Kaggle which contains the physicochemical properties and sensory ratings of 4898 white wines and 1599 red wines from the north of Portugal. The goal is to predict the quality of the wine, which is scored between 0 and 10.

1.) fixed_acidity: The set of low volatility organic acids.

2.) volatile_acidity: The set of short chain organic acids that can be extracted from the sample by means of a distillation process.

3.) citric acid: A type of fixed acidity.

4.) residual_sugar: The natural grape sugars left in a wine after the alcoholic fermentation finishes.

5.) chlorides: A major contributor to the saltiness of wine.

6.) free_sulfer_dioxide: Sulfur that is able to react, which exhibits both germidical and antioxidant properties.

7.) total_sulfur_dioxide: Sum of free and bound sulfur. Bound sulfites are those that have reacted with other molecules.

8.) density: Measure of the concentration of alcohol, sugar, glycerol, and other dissolved solids.

9.) pH: The pH spectrum of wine.

10.) sulphates: Act as both a wine's preservative and enhancer.

11.) type: Red(=1) or White(=0) [binary]

12.) quality: Quality score between 0 and 10.

More info about the dataset can be found below:

- Kaggle: [Wine Quality](https://www.kaggle.com/datasets/rajyellow46/wine-quality/data)
- UCI Machine Learning Repository: [Wine Quality](https://archive.ics.uci.edu/dataset/186/wine+quality)

## Analytic Techniques and Models

The following techniques are used to build this project:

- Language: Python
- Analysis & Model Training: Jupyter Notebook
- Libraries & Methods: pandas, sklearn, statsmodel API, numpy, matplotlib

## Step 1: Data Acquisition

As mentioned above, the dataset used for this project was sourced from Kaggle and then subsequently imported into Jupyter Notebook for regression analysis and classification. Below are sample rows from the dataset.

| type | fixed acidity | volatile acidity | citric acid | residual sugar | chlorides | free sulfur dioxide | total sulfur dioxide | density | pH   | sulphates | alcohol | quality |
|------|---------------|------------------|-------------|----------------|-----------|----------------------|-----------------------|---------|------|-----------|---------|---------|
| white | 7             | 0.27             | 0.36        | 20.7           | 0.045     | 45                   | 170                   | 1.001   | 3    | 0.45      | 8.8     | 6       |
| white | 6.3           | 0.3              | 0.34        | 1.6            | 0.049     | 14                   | 132                   | 0.994   | 3.3  | 0.49      | 9.5     | 6       |
| white | 8.1           | 0.28             | 0.4         | 6.9            | 0.05      | 30                   | 97                    | 0.9951  | 3.26 | 0.44      | 10.1    | 6       |
| white | 7.2           | 0.23             | 0.32        | 8.5            | 0.058     | 47                   | 186                   | 0.9956  | 3.19 | 0.4       | 9.9     | 6       |
| white | 7.2           | 0.23             | 0.32        | 8.5            | 0.058     | 47                   | 186                   | 0.9956  | 3.19 | 0.4       | 9.9     | 6       |
| white | 8.1           | 0.28             | 0.4         | 6.9            | 0.05      | 30                   | 97                    | 0.9951  | 3.26 | 0.44      | 10.1    | 6       |
| white | 6.2           | 0.32             | 0.16        | 7              | 0.045     | 30                   | 136                   | 0.9949  | 3.18 | 0.47      | 9.6     | 6       |
| white | 7             | 0.27             | 0.36        | 20.7           | 0.045     | 45                   | 170                   | 1.001   | 3    | 0.45      | 8.8     | 6       |
| white | 6.3           | 0.3              | 0.34        | 1.6            | 0.049     | 14                   | 132                   | 0.994   | 3.3  | 0.49      | 9.5     | 6       |
| white | 8.1           | 0.22             | 0.43        | 1.5            | 0.044     | 28                   | 129                   | 0.9938  | 3.22 | 0.45      | 11      | 6       |
| white | 8.1           | 0.27             | 0.41        | 1.45           | 0.033     | 11                   | 63                    | 0.9908  | 2.99 | 0.56      | 12      | 5       |
| white | 8.6           | 0.23             | 0.4         | 4.2            | 0.035     | 17                   | 109                   | 0.9947  | 3.14 | 0.53      | 9.7     | 5       |
| white | 7.9           | 0.18             | 0.37        | 1.2            | 0.04      | 16                   | 75                    | 0.992   | 3.18 | 0.63      | 10.8    | 5       |
| white | 6.6           | 0.16             | 0.4         | 1.5            | 0.044     | 48                   | 143                   | 0.9912  | 3.54 | 0.52      | 12.4    | 7       |
| white | 8.3           | 0.42             | 0.62        | 19.25          | 0.04      | 41                   | 172                   | 1.0002  | 2.98 | 0.67      | 9.7     | 5       |
| white | 6.6           | 0.17             | 0.38        | 1.5            | 0.032     | 28                   | 112                   | 0.9914  | 3.25 | 0.55      | 11.4    | 7       |
| white | 6.3           | 0.48             | 0.04        | 1.1            | 0.046     | 30                   | 99                    | 0.9928  | 3.24 | 0.36      | 9.6     | 6       |
| white |               | 0.66             | 0.48        | 1.2            | 0.029     | 29                   | 75                    | 0.9892  | 3.33 | 0.39      | 12.8    | 8       |
| white | 7.4           | 0.34             | 0.42        | 1.1            | 0.033     | 17                   | 171                   | 0.9917  | 3.12 | 0.53      | 11.3    | 6       |
| white | 6.5           | 0.31             | 0.14        | 7.5            | 0.044     | 34                   | 133                   | 0.9955  | 3.22 | 0.5       | 9.5     | 5       |


## Step 2: Linear Regression Feature Selection and Training

### I first trained a linear regression model to predict the wine quality score. I utilized 70% of the dataset as the training data and the remaining 30% as the test data, ensuring to maintain consistency by using the same random state number for data split.

```python
# 1a.) Training a linear regression model to predict the wine quality score with feature selection. (70% training set : 30% test set)

import pandas as pd
import numpy as np
import os
from sklearn.model_selection import train_test_split
import statsmodels.formula.api as smf
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import variance_inflation_factor

wine = pd.read_csv('wine_quality.csv')
wine.head()
```

| fixed_acidity | volatile_acidity | citric_acid | residual_sugar | chlorides | free_sulfur_dioxide | total_sulfur_dioxide | density | pH   | sulphates | alcohol | type | quality |
|---------------|------------------|-------------|----------------|-----------|----------------------|----------------------|---------|------|-----------|---------|------|---------|
| 7.0           | 0.27             | 0.36        | 20.7           | 0.045     | 45.0                 | 170.0                | 1.0010  | 3.00 | 0.45      | 8.8     | 0    | 6       |
| 6.3           | 0.30             | 0.34        | 1.6            | 0.049     | 14.0                 | 132.0                | 0.9940  | 3.30 | 0.49      | 9.5     | 0    | 6       |
| 8.1           | 0.28             | 0.40        | 6.9            | 0.050     | 30.0                 | 97.0                 | 0.9951  | 3.26 | 0.44      | 10.1    | 0    | 6       |
| 7.2           | 0.23             | 0.32        | 8.5            | 0.058     | 47.0                 | 186.0                | 0.9956  | 3.19 | 0.40      | 9.9     | 0    | 6       |
| 7.2           | 0.23             | 0.32        | 8.5            | 0.058     | 47.0                 | 186.0                | 0.9956  | 3.19 | 0.40      | 9.9     | 0    | 6       |

```python
from sklearn.model_selection import train_test_split

# Splitting the dataset
wine_train, wine_test = train_test_split(wine, test_size=0.3, random_state=88)

# Displaying the shape of the train and test datasets
wine_train.shape, wine_test.shape
```

```plaintext
((4547, 13), (1950, 13))
```


### Initially, I ran the model with the inclusion of all the regressors to get a benchmark for the R² which turned out to be a very bad fit given the sub 0.3 R².

```python
wine_train.head()
```
| fixed_acidity | volatile_acidity | citric_acid | residual_sugar | chlorides | free_sulfur_dioxide | total_sulfur_dioxide | density | pH  | sulphates | alcohol | type | quality |
|---------------|------------------|-------------|----------------|-----------|----------------------|----------------------|---------|-----|-----------|---------|------|---------|
| 10.6          | 0.48             | 0.64        | 2.2            | 0.111     | 6.0                  | 20.0                 | 0.9970  | 3.26| 0.66      | 11.7    | 1    | 6       |
| 7.5           | 0.14             | 0.34        | 1.3            | 0.055     | 50.0                 | 153.0                | 0.9945  | 3.29| 0.80      | 9.6     | 0    | 6       |
| 5.6           | 0.21             | 0.24        | 4.4            | 0.027     | 37.0                 | 150.0                | 0.9910  | 3.30| 0.31      | 11.5    | 0    | 7       |
| 9.0           | 0.44             | 0.49        | 2.4            | 0.078     | 26.0                 | 121.0                | 0.9978  | 3.23| 0.58      | 9.2     | 1    | 5       |
| 6.7           | 0.20             | 0.42        | 14.0           | 0.038     | 83.0                 | 160.0                | 0.9987  | 3.16| 0.50      | 9.4     | 0    | 6       |

```python
target_column = 'quality'
feature_columns = [col for col in wine_train.columns if col != target_column]
all_features = ' + '.join(feature_columns)
all_features
```

```plaintext
'fixed_acidity + volatile_acidity + citric_acid + residual_sugar + chlorides + free_sulfur_dioxide + total_sulfur_dioxide + density + pH + sulphates + alcohol + type'
```

```python
ols = smf.ols(formula='quality ~ ' + all_features, data=wine_train)
model1 = ols.fit()
print(model1.summary())
```

```plaintext
OLS Regression Results                            
==============================================================================
Dep. Variable:                quality   R-squared:                       0.295
Model:                            OLS   Adj. R-squared:                  0.293
Method:                 Least Squares   F-statistic:                     158.1
Date:                Thu, 23 Mar 2023   Prob (F-statistic):               0.00
Time:                        17:39:31   Log-Likelihood:                -5027.6
No. Observations:                4547   AIC:                         1.008e+04
Df Residuals:                    4534   BIC:                         1.016e+04
Df Model:                          12                                         
Covariance Type:            nonrobust
```


### Subsequently, I did feature selection using VIFs and P-Value to only include regressors with low VIFs and significant p-values.

```python
regressors = ['fixed_acidity', 'volatile_acidity', 'citric_acid', 'residual_sugar', 'chlorides', 'free_sulfur_dioxide', 'total_sulfur_dioxide', 'density', 'pH', 'sulphates', 'alcohol', 'type']

# Function to compute VIFs
def VIF(df, columns):
    values = sm.add_constant(df[columns]).values
    num_columns = len(columns) + 1
    vif = [variance_inflation_factor(values, i) for i in range(num_columns)]
    return pd.Series(vif[1:], index=columns)

VIF(wine_train, regressors)
```

```plaintext
fixed_acidity            4.817241
volatile_acidity         2.121607
citric_acid              1.614725
residual_sugar           9.320133
chlorides                1.651829
free_sulfur_dioxide      2.214714
total_sulfur_dioxide     3.961942
density                 21.611229
pH                       2.467010
sulphates                1.543964
alcohol                  5.444707
type                     6.703327
dtype: float64
```


### Ultimately, my final linear regression model included: volatile_acidity, residual_sugar, chlorides, free_sulfur_dioxide, total_sulfure_dioxide, sulphates, alcohol, and type as the indepenedent variables to predict the quality of the wine. I chose variables to include in my linear regression model by removing a variable one-by-one starting with the highest VIF while continuously recomputing the VIFs after removing the variable until all of the remaining variables have a VIF low enough (generally below 5). In addition, I also removed variables that had a high p-value that remnained after using VIFs to eliminate the outliers until all of the remaining regressors have a p-value significant at our traditional cutoff levels of 1% and 5%.

## Step 3: Linear Regression Model Evaluation

### With the finalized linear regression model, I applied it to predict quality scores for the test data and compared it with the actual quality.

```python
# Using my final linear regression model to predict quality scores for the test data and appending it to compare with actual quality

quantity_prediction = model1_final.predict(wine_test)
wine_test_copy = wine_test
wine_test_copy['quality_hat'] = quantity_prediction
wine_test_results = wine_test_copy.iloc[:, [12,13]]
wine_test_results
```

| quality | quality_hat |
|---------|-------------|
| 5       | 4.565673    |
| 5       | 5.948929    |
| 5       | 4.873529    |
| 6       | 5.725694    |
| 5       | 5.372204    |
| ...     | ...         |
| 6       | 5.904938    |
| 5       | 5.736617    |
| 5       | 5.348696    |
| 5       | 5.812864    |
| 5       | 5.229511    |

1950 rows × 2 columns


### Below I conduct post-processing of the predicted quality scores by rounding each prediction to the nearest integer:

#### Refine the predicted quality scores (continuous) to integer values between 0 and 10.
```python
# rounding the predicted quality to integers

y_temp = wine_test_results['quality_hat']
y_approximation = []

for i in y_temp:
    y_temp_round = np.around(i)
    y_approximation.append(int(y_temp_round))
  
wine_test_results['quality_hat_rounded'] = y_approximation # appending the rounded quality predictions
wine_test_results
```

| quality | quality_hat | quality_hat_rounded |
|---------|-------------|---------------------|
| 5534    | 5           | 4.565673            | 5                   |
| 3429    | 5           | 5.948929            | 6                   |
| 4899    | 5           | 4.873529            | 5                   |
| 3091    | 6           | 5.725694            | 6                   |
| 645     | 5           | 5.372204            | 5                   |
| ...     | ...         | ...                 | ...                 |
| 145     | 6           | 5.904938            | 6                   |
| 5902    | 5           | 5.736617            | 6                   |
| 2047    | 5           | 5.348696            | 5                   |
| 4973    | 5           | 5.812864            | 6                   |
| 3893    | 5           | 5.229511            | 5                   |
| 1950 rows × 3 columns                         |


### Finally, I evaluate the performance of my linear regression model in predicting quality scores which turned out to be quite lackluster with an accuracy of around 33%. This suggests that a linear regression model is likely not the best fit for the data. 

```python
# Count how many accurate predictions we had by comparing the actual quality with the rounded predicted quality for each row

expected = []
predicted = []
count = 0  # Count is the number of accurate predictions from our training set model

for i in wine_test_results['quality']:
    expected.append(i)

for j in wine_test_results['quality_hat_rounded']:
    predicted.append(j)

for k in range(1950):
    if expected[k] == predicted[k]:
        count += 1

count
```

```plaintext
645
```

```python
# Compute accuracy for the test set

accuracy = count / len(wine_test)
accuracy
```

```plaintext
0.33076923076923076
```


## Step 4: Logistic Regression Model 1 Feature Selection and Training

### I then sought to train a logistic regression variable with the below formula where I let X be a vector of the independent variables except the Type, i.e., (fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates), and Z be a binary variable s.t. Z = 1 if the type of the wine is red, and Z = 0 if the type of the wine is white. Y = 1 indicates the wine is premium, Y = 0 otherwise. (wines with quality scores >= 7 are considered premium.)

$$
\text{Pr}(Y = 1 | X, Z) = \frac{1}{1 + e^{-(\beta_0 + \beta_1^T X + \beta_2 Z)}}
$$

```python
# Quality of 7 or greater is considered premium
premium_or_not = []  # Stores boolean indicator for whether the wine is premium or not

for i in wine_train['quality']:
    if (i >= 7):
        premium_or_not.append(1)
    else:
        premium_or_not.append(0)

wine_train['premium'] = premium_or_not

# Fit logistic regression model
logreg = smf.logit(formula='premium ~ fixed_acidity + volatile_acidity + citric_acid + residual_sugar + chlorides + free_sulfur_dioxide + total_sulfur_dioxide + density + pH + sulphates + type', data=wine_train)
logreg_model = logreg.fit()

# Display model summary
logreg_model.summary()
```
```plaintext
Optimization terminated successfully.
         Current function value: 0.388998
         Iterations 8
```

```plaintext
Logit Regression Results

| Dep. Variable          | premium                 |
|------------------------|-------------------------|
| Model                  | Logit                   |
| Method                 | MLE                     |
| Date                   | Thu, 23 Mar 2023        |
| Time                   | 17:39:34                |
| No. Observations       | 4547                    |
| Df Residuals           | 4535                    |
| Df Model               | 11                      |
| Pseudo R-squ.          | 0.2142                  |
| Log-Likelihood         | -1768.8                 |
| LL-Null                | -2251.0                 |
| Covariance Type        | nonrobust               |
| LLR p-value            | 8.568e-200              |
| converged              | True                    |

                         | coef     | std err |    z   | P>|z|   | [0.025  |  0.975] |
|------------------------|----------|---------|--------|---------|---------|---------|
| Intercept              | 757.3910 | 37.185  | 20.368 | 0.000   | 684.510 | 830.272 |
| fixed_acidity          | 0.7901   | 0.063   | 12.600 | 0.000   | 0.667   | 0.913   |
| volatile_acidity       | -4.0173  | 0.464   | -8.656 | 0.000   | -4.927  | -3.108  |
| citric_acid            | -0.1652  | 0.414   | -0.399 | 0.690   | -0.977  | 0.646   |
| residual_sugar         | 0.3433   | 0.021   | 16.708 | 0.000   | 0.303   | 0.384   |
| chlorides              | -6.9843  | 2.837   | -2.461 | 0.014   | -12.546 | -1.423  |
| free_sulfur_dioxide    | 0.0098   | 0.003   | 2.820  | 0.005   | 0.003   | 0.017   |
| total_sulfur_dioxide   | -0.0022  | 0.002   | -1.386 | 0.166   | -0.005  | 0.001   |
| density                | -783.5069| 38.358  | -20.426| 0.000   | -858.686| -708.328|
| pH                     | 3.7800   | 0.362   | 10.445 | 0.000   | 3.071   | 4.489   |
| sulphates              | 3.0408   | 0.322   | 9.442  | 0.000   | 2.410   | 3.672   |
| type                   | 1.7036   | 0.259   | 6.589  | 0.000   | 1.197   | 2.210   |
```


### My final logistic regression model for the aforementioned formula consisted of the variables: fixed_acidity, volatile_acidity, residual_sugar, chlorides, free_sulfur_dioxide, density pH, sulphates, and type as the independent variables. I chose those regressors to keep by using backward elimination. That is to say I started with the full model that included all the independent variables of interest, and then removing one variable at a time based on its p-value until all remaining variables have a p-value below the threshold of 0.05

```plaintext
Optimization terminated successfully.
         Current function value: 0.389016
         Iterations 8
```

```plaintext
Logit Regression Results

| Dep. Variable          | premium                 |
|------------------------|-------------------------|
| Model                  | Logit                   |
| Method                 | MLE                     |
| Date                   | Thu, 23 Mar 2023        |
| Time                   | 17:39:34                |
| No. Observations       | 4547                    |
| Df Residuals           | 4537                    |
| Df Model               | 9                       |
| Pseudo R-squ.          | 0.2137                  |
| Log-Likelihood         | -1769.9                 |
| LL-Null                | -2251.0                 |
| Covariance Type        | nonrobust               |
| LLR p-value            | 2.449e-201              |
| Converged              | True                    |

                         | coef     | std err |   z   | P>|z|   | [0.025  |  0.975] |
|------------------------|----------|---------|--------|--------|---------|---------|
| Intercept              | 770.4157 | 35.378  | 21.777 | 0.000  | 701.077 | 839.754 |
| fixed_acidity          | 0.7895   | 0.057   | 13.759 | 0.000  | 0.677   | 0.902   |
| volatile_acidity       | -4.0691  | 0.438   | -9.300 | 0.000  | -4.927  | -3.212  |
| residual_sugar         | 0.3452   | 0.020   | 17.004 | 0.000  | 0.305   | 0.385   |
| chlorides              | -7.1027  | 2.838   | -2.503 | 0.012  | -12.664 | -1.541  |
| free_sulfur_dioxide    | 0.0069   | 0.003   | 2.480  | 0.013  | 0.001   | 0.012   |
| density                | -796.8700| 36.509  | -21.827| 0.000  | -868.426| -725.314|
| pH                     | 3.7901   | 0.361   | 10.499 | 0.000  | 3.083   | 4.498   |
| sulphates              | 3.0147   | 0.320   | 9.408  | 0.000  | 2.387   | 3.643   |
| type                   | 1.9061   | 0.219   | 8.717  | 0.000  | 1.477   | 2.335   |
```


## Step 5: Logistic Regression Model 1 Evaluation

### I evaluated the performance of my first logistic regression model by calculating its accuracy and confusion matrix, where the results of both indicated a much higher accuracy and fit for the data compared to the linear regression model.

![2b](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/5997c15c-121f-4151-8ccc-5f052dd3bac8)

## Step 6: Logistic Regression Model 2 Feature Selection and Training

### In this step, I  altered the formula of the logistic regression model to train a second model to investigate potential improvements in accuracy. (using the same training data and test data as the original split)

$$
\text{Pr}(Y = 1 | X, Z) = Z\left(\frac{1}{1 + e^{-(\alpha_0 + \alpha_1^T X)}}\right) + (1 - Z)\left(\frac{1}{1 + e^{-(\beta_0 + \beta_1^T X)}}\right)
$$

![2c part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/c711390a-c3f1-4d60-9a6d-19a0b8fbe9d6)

![2c part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/050c8a2b-40da-44f4-b3c0-ffb4e8deb15b)

### Similar to the first logistic regression model, I used backward elimination to choose regressors to keep. Because the new logistic model assumes the use of two sigmoid functions that depend on whether Z = 0 or Z = 1, we can train them separately. Below is my final model for the Z = 1 portion of the sigmoid function after using backwards elimination.

![2c part 3](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/5ec0b113-5183-4de8-ad60-864327a9f656)

### Below is my final model for the Z = 0 portion of the sigmoid function:

![2c part 4](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/b7f68d3c-271f-4cd9-9388-048adb57d3dc)

### Because our logistic model assumed the use of two sigmoid functions that depend on whether Z = 0 or Z = 1, we can train them separately. We can accomplish this by dividing our training data (X,Z) into two subsets: (X, Z=1) and (X,Z=0). When Z = 1, we can fit the corresponding X feature data using maximum likelihood estimation to the sigmoid function parameterized by alpha's, and the same for beta's when Z = 0. For the separate models, I removed regressors based on the p-value threshold of 0.05 until all remaining regressors were significant at the 5% level. Afterward, we can merge the two fitted logistic models to create the complete logistic model that computes the Pr(Y=1|X).

## Step 7: Logistic Regression Model 2 Evaluation

### Finally, we can evaluate the accuracy and the confusion matrix of our second logistic regression model.

![2d part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/48e766e9-97d2-4aa0-901c-cc1a5531ee7b)

![2d part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/0b8f64c7-cf91-4dbd-8cc4-385dce0743d3)

### In the end, both of the logistic regression models performed well and pretty similarly. The calculated accuracy of both were both around 80%, a welcome improvement to the original linear regression model.

## Step 8: Linear Discriminant Analysis Training and Evaluation

### Finally, I train an LDA model to predict the wine quality score. Using the same trainig data and test data as in the first part. I employ the same set of features I chose for my first logistic regression model.

![3a](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/6253465f-597a-4ab8-816c-bc602d36ca5a)

### The computed accuracy and confusion matrix for the LDA model proves comparable to that of the logistic regression models.  (even slightly more accurate)

![3b](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/f21b8a23-0a49-46c9-8d26-bc490a6fe416)

## Step 9: ROC Curve

### To conclude, I graph the following 4 models in one graph and compute the AUC (area under curve) for each:
- Baseline Model (predict 1 with probability p and 0 with probability 1-p)
- Logistic Regression Model 1
- Logistic Regression Model 2
- LDA Model

![3c part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/1b6e9608-a4d6-42b7-aa84-f658c7fa900d)

![3c part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/19f0400b-c603-4840-ad2b-41350698357f)

### We know that the AUC of a ROC curve is a measure of how well the model can distinguish between positive and negative classes, regardless of the classification threshold. It ranges from 0 to 1, with 0.5 indicating random performance and 1 indicated perfect performance. In other words, the AUC is a summary of the ROC curve that provides a single number to represent the overall quality of a classification model. A higher AUC indicates better classification performance, while a lower AUC indicates poorer performance. Therefore, these are the 4 ROC curves produced from each of the models and it appears the the first logistic regression, second logistic regression, and LDA models all had very similar performance with the second logistic regression model performing just slightly better than the other two.
