# 🍷 Wine Quality Prediction Project

## My Jupyter Notebook

You can view my Jupyter Notebook: [here]()

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
- [Step 6: Logistic Regression Model 1 Feature Selection & Training](#step-6-logistic-regression-model-2-feature-selection-and-training)
- [Step 7: Logistic Regression Model 1 Evaluation](#step-7-logistic-regression-model-2-evaluation)
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

### Part a.) I trained a linear regression model to predict the wine quality score. I utilized 70% of the dataset as the training data and the remaining 30% as the test data, ensuring to maintain consistency by using the same random state number for data split. Additionally, I performed feature selection and provided reasonable explanation for my choice of features.
