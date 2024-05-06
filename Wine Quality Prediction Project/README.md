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

![sample wine rows](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/ef4491a2-4363-4713-8126-d96ea8191c66)

## Step 2: Linear Regression Feature Selection and Training

### I first trained a linear regression model to predict the wine quality score. I utilized 70% of the dataset as the training data and the remaining 30% as the test data, ensuring to maintain consistency by using the same random state number for data split.

![1a part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/4934acf1-01e2-43d5-89f0-9c04cc2dff4d)

### Initially, I ran the model with the inclusion of all the regressors to get a benchmark for the R² which turned out to be a very bad fit given the sub 0.3 R².

![1a part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/4695ab16-3c42-452a-9200-888fee52ce06)

### Subsequently, I did feature selection using VIFs and P-Value to only include regressors with low VIFs and significant p-values.

![1a part 3](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/0c182cd7-36b5-4637-b90e-4980bb8b532b)

### Ultimately, my final linear regression model included: volatile_acidity, residual_sugar, chlorides, free_sulfur_dioxide, total_sulfure_dioxide, sulphates, alcohol, and type as the indepenedent variables to predict the quality of the wine. I chose variables to include in my linear regression model by removing a variable one-by-one starting with the highest VIF while continuously recomputing the VIFs after removing the variable until all of the remaining variables have a VIF low enough (generally below 5). In addition, I also removed variables that had a high p-value that remnained after using VIFs to eliminate the outliers until all of the remaining regressors have a p-value significant at our traditional cutoff levels of 1% and 5%.

## Step 3: Linear Regression Model Evaluation

### With the finalized linear regression model, I applied it to predict quality scores for the test data and compared it with the actual quality.

![1b](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/2df7440e-693c-4622-a5b4-a91985dad006)

### Below I conduct post-processing of the predicted quality scores by rounding each prediction to the nearest integer:

![1c part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/3824a438-1d85-4a87-8664-7ce9931e18e7)

### Finally, I evaluate the performance of my linear regression model in predicting quality scores which turned out to be quite lackluster with an accuracy of around 33%. This suggests that a linear regression model is likely not the best fit for the data. 

![1c part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/16ae75b4-b4ed-47a8-b5b9-1e01497236cf)

## Step 4: Logistic Regression Model 1 Feature Selection and Training

### I then sought to train a logistic regression variable with the below formula where I let X be a vector of the independent variables except the Type, i.e., (fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates), and Z be a binary variable s.t. Z = 1 if the type of the wine is red, and Z = 0 if the type of the wine is white. Y = 1 indicates the wine is premium, Y = 0 otherwise. (wines with quality scores >= 7 are considered premium.)

$$
\text{Pr}(Y = 1 | X, Z) = \frac{1}{1 + e^{-(\beta_0 + \beta_1^T X + \beta_2 Z)}}
$$

![2a part 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/178acfe2-2c55-4ca0-8c89-35a5a146f9c5)

![2a part 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/435f64c9-c18e-474d-8341-47f7a06f2c33)

### My final logistic regression model for the aforementioned formula consisted of the variables: fixed_acidity, volatile_acidity, residual_sugar, chlorides, free_sulfur_dioxide, density pH, sulphates, and type as the independent variables. I chose those regressors to keep by using backward elimination. That is to say I started with the full model that included all the independent variables of interest, and then removing one variable at a time based on its p-value until all remaining variables have a p-value below the threshold of 0.05

![2a part 3](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/d858694b-fa09-4aa8-b375-b94741a45f6a)

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

### Because our logistic model assumed the use of two sigmoid functions that depend on whether Z = 0 or Z = 1, we can train them separately. We can accomplish this by dividing our training data (X,Z) into two subsets: (X, Z=1) and (X,Z=0). When Z = 1, we can fit the corresponding X feature data using maximum likelihood estimation to the sigmoid function parameterized by alpha's, and the same for beta's when Z = 0. For the separate models, I removed regressors based on the p-value threshold of 0.05 until all remaining regressors were significant at the 5% level. Afterward, we can merge the two fitted logistic models to create the complete logistic model that computes the Pr(Y=1|X).\

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
