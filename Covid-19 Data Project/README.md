# 🦠 Covid-19 Data Exploration

## My Jupyter Notebook

You can view my Jupyter Notebook: [here](https://nbviewer.org/github/RobinsonKao/Portfolio-Projects/blob/main/Covid-19%20Data%20Project/Covid-19%20Data.ipynb)

## Objective

This project delves into a comprehensive examination of COVID-19 data from the beginning of lockdown until September 2021, with a particular focus on exploring potential correlations between variables. My running hypothesis suggests a positive correlation between changes in death rates and changes in vaccination rates, specifically in response to individuals receiving their first dosage of the vaccine. I postulate that a significant increase in death rates might act as a motivating factor, prompting individuals to seek vaccination more urgently, thus potentially explaining this correlation. Throughout this project, I showcase proficiency in:

Conducting data cleaning and exploratory data analysis (EDA) utilizing Pandas.
Implementing both unsupervised and supervised learning techniques.
Creating informative visualizations to effectively communicate insights gleaned from the data.

This document will offer my final report, emphasizing the key data modeling outputs pivotal in shaping my hypothesis. Additionally, it will address inherent limitations and suggest avenues for future work, including the incorporation of more recent data and the rectification of identified shortcomings.

## Table of Content

- [Datasets Used](#datasets-used)
- [Analytic Techniques and Models](#analytic-techniques-and-models)
- [My Hypothesis](#my-hypothesis)
- [Hypothesis Testing](#hypothesis-testing)
- [Exploratory Data Analysis Part 1](#exploratory-data-analysis-part-1)
- [Exploratory Data Analysis Part 2](#exploratory-data-analysis-part-2)
- [Models](#models)
- [Model Improvement](#model-improvement)
- [Challenges I Encountered](#challenges-i-encountered)
- [Results](#results)
- [Future Work](#future-work)

## Datasets Used

Cases (stored as variable "cases")
- A dataset that provides county-wise information sorted by each of the fifty states regarding the number of COVID-19 cases for each day in a 600-day period from the pandemic

Vaccinations (stored as variable "vaccinations")
- A dataset that provides a snapshot of vaccination rates for the population of each county within each state delineated by those partially vaccinated and fully vaccinated
- This dataset includes data for each individual day in a predefined 600-day period from the pandemic

Counties (stored as variable "counties")
- A dataset that provides county-wise data for each county within each state and its population estimates at different snapshots in time (ie. population estimate for the year 2012 or 2014)

Mask Usage (stored as variable "mask_use")
- A dataset that provides data that associates the population within a specific county in the U.S. with 5 predefined tendencies for mask usage: "never", "rarely", "sometimes", "frequently", "always"
- The dataset then assigns the appropriate proportion to each of the 5 tendencies for mask usage based on what proportion of people in that county fall under each category

Death Tolls (stored as variable "notable_deaths")
- A dataset imported from the CDC that provides information on the death tolls for each state along with the time data associated with the death count, delineated by each individual day
- The time data is a crucial component for the exploration of my hypothesis as I explore the correlation of increasing COVID death rates with vaccination rates in a time interval

## Analytic Techniques and Models

The following technologies are used to build this project:

- Language: Python
- Extraction and transformation: Jupyter Notebook
- Libraries and Methods: pandas, sklearn, geopy, numpy, matplotlib, seaborn, plotly, scipy

## My Hypothesis

I hypothesized that the change in death rates is positively correlated with the change in vaccination rates in people's first dosage as a response. That is to say that a bigger spike in death rates may motivate and incentivize people to get vaccinated more urgently, which may explain this correlation,

## Hypothesis Testing

I will test this hypothesis by utilizing the aforementioned datasets, compiling the day-by-day death tolls and case counts for each state, and computing the mean values. Then I can use the mean values and create visualizations to display correlations between the death rates and subsequent vaccination rates over a given time interval to identify supporting or confounding evidence for the hypothesis.

## Exploratory Data Analysis Part 1

The initial phase of exploratory data analysis involved examining the month-to-month variations in vaccination and mortality rates, expressed as percentage differences, across four selected states. These states were strategically chosen based on principal component analysis (PCA) data, with one state selected from each hemisphere cluster. The rationale behind this selection approach was to discern potential disparities among states within PCA regions. Subsequently, for the second exploratory data analysis, a comprehensive aggregation was conducted across all states. This decision aimed to avoid cluttering the analysis with excessive plotting while still capturing overarching trends.

![image](https://github.com/user-attachments/assets/7791fded-6472-4af3-9535-ff31285acd1b)

To structure the data appropriately, I began by converting the columns into proper datetime objects and subsequently merged the data based on states and dates. Following this, I generated additional columns to calculate the percentage changes in both partial and full vaccinations separately, as well as the month-to-month percentage change in deaths.

```python
from datetime import datetime
# [outlier, Large cluster, tight cluster, one of an outlier pair, cluster, loose cluster, cluster, outlier]
# notable_states = ['ND', 'ID', 'LA', 'CO', 'TX', 'WA', 'NY', 'HA']
notable_states = ['ID', 'CO', 'TX', 'NY', 'HA']
notable_deaths = deaths[deaths['state'].isin(notable_states)]
notable_deaths
```

I opted for calculating percentage changes as it offers a more visually interpretable representation compared to per capita increases. During the initial exploration, I observed that death rates were significantly lower than vaccination rates across all datasets. Consequently, the per capita approach in my first iteration of this EDA yielded minimal values, making it challenging to discern correlations. By transitioning to percentage changes, this effectively mitigated the disparity in per capita values, scaling the data uniformly. As a result, the correlation within the data became distinctly clear through percentages.

![image](https://github.com/user-attachments/assets/add5b3f4-be3f-4a44-8917-780232c127c4)

![image](https://github.com/user-attachments/assets/e4e1a9e2-91a6-48d9-80ef-7f84a3eeb315)

![image](https://github.com/user-attachments/assets/8fa4467b-6b18-4e3b-b05f-3462e8c01593)

![image](https://github.com/user-attachments/assets/bbed4156-0917-4d87-b176-f0d90a7d67cc)

In the end, I opted to aggregate the data on a month-to-month basis rather than a day-to-day basis because I observed that percentage changes on a daily scale exhibited excessive fluctuations, making trend identification challenging. Aggregating month-to-month facilitated clearer trend visualization, as it smoothed out fluctuations and highlighted more discernible patterns.

## Exploratory Data Analysis Part 2

For my second exploratory data analysis (EDA), I opted to aggregate daily total per capita death and vaccination rates across the entire United States. I chose this approach deliberately as it offers a distinct aggregation method from my initial EDA. My hypothesis posited that such nationwide aggregation, coupled with daily comparisons, would afford us a fresh perspective compared to our previous analysis. By conducting EDA in this manner, I aimed to identify anomalies deviating from expected consistent upward trends. The anticipated pattern entails death rates, vaccinations, and partial vaccinations increasing at a relatively constant pace, making any deviations potentially indicative of significant insights pertinent to the hypothesis.

```python
# This code plots the percent change in partial vaccination over all available dates for the USA
# It then identifies the date with the maximum percent change in partial vaccination

plt.plot(all_state_by_date.index, all_state_by_date['partial_vax_per_capita'])
plt.title("USA Percent Change in Partial Vaccination over all Available Dates")
plt.xlabel("Date")
plt.ylabel("Percent Change in Partial Vaccination")
np.max(all_state_by_date['partial_vax_per_capita'])
all_state_by_date['partial_vax_per_capita'].idxmax(0.14237115941655223)
```

![image](https://github.com/user-attachments/assets/37911d0b-7d1b-4af0-b923-352419d2b599)

```python
# This code plots the percent change in full vaccination over all available dates for the USA.

plt.plot(all_state_by_date.index, all_state_by_date['full_vax_per_capita'])
plt.title("USA Percent Change in Full Vaccination over all Available Dates")
plt.xlabel("Date")
plt.ylabel("Percent Change in Full Vaccination")
```

![image](https://github.com/user-attachments/assets/19f97712-18ba-4c2d-9fa9-db29c49084de)

```python
# The code plots the percent change in deaths over all available dates for the USA

plt.plot(all_state_by_date.index, all_state_by_date['tot_death_per_capita'])
plt.title("USA Percent Change in Deaths over all Available Dates")
plt.xlabel("Date")
plt.ylabel("Percent Change in Deaths")
```

![image](https://github.com/user-attachments/assets/abe7d723-e9d0-49fb-a9bb-1954d285f41c)

## Models

In my model, I conducted a linear regression analysis between the month-to-month percentage changes in death rates and vaccination rates. The resulting root mean square error (RMSE) of 0.69 was relatively large compared to the dataset's measurements, which typically hovered around 1.0, indicating a weak correlation between the variables. This inference is supported by a graphical representation illustrating the disparity between my predicted percentage changes in vaccination rates and the actual percentage changes observed from February 2021 to September 2021.

```python
# This code plots the predicted and actual percentage change in vaccination rates over the months of February to September 2021, using a line plot.

plt.subplots()
sns.lineplot(np.arange(2,10), death_vs_vacc_pred, label = 'Predicted')
sns.lineplot(np.arange(2,10), all_state_by_month['Percent Change Vaccination'].iloc[2:], label = 'Actual')
plt.title("Percent Change in Vaccination Over the Months of February to September 2021")
plt.xlabel('Month')
```
![image](https://github.com/user-attachments/assets/234c93a8-fd67-430e-87db-1281ecd720d3)

Furthermore, I plotted the mean squared error (MSE) to underscore the extent of the model's inaccuracies relative to the actual values.

```python
# The code generates a line plot showing the mean squared error (MSE) of the model's predictions compared to the actual percentage change in vaccination rates over the months of February to September 2021.

predicted_minus_actual = (death_vs_vacc_pred - all_state_by_month['Percent Change Vaccination'].iloc[2:])**2
sns.lineplot(np.arange(2,10), predicted_minus_actual)
plt.xlabel('Month')
plt.ylabel('MSE of Model')
plt.title('MSE of Model For Each Month between February to September 2021')
```

![image](https://github.com/user-attachments/assets/cc41da5d-ace6-4382-84e3-6d21bde742d0)

The majority of the plot illustrates the mean squared error (MSE) exceeding 0, particularly notable in the second month. This discrepancy vividly illustrates the deviation between my model's predictions and the actual values, rendering it unnecessary to mentally compare the two plots directly. Given that the percentage differences are generally small, averaging around 1%, an MSE visibly surpassing 2.5 strongly indicates a lack of correlation between changes in death rates and changes in vaccination rates.

## Model Improvement

To enhance my model's performance, I introduced several adjustments, including the integration of time series modeling. I explored this approach with both monthly and daily data. For the monthly data, I fitted the month-to-month percentage changes in deaths to the month-to-month percentage changes in vaccinations. Subsequently, I developed a time series model to assess the progression of month-to-month vaccination rate changes. This time series model was employed twice. Initially, I utilized it to predict the next month's percentage change as shown below.

```python
# This code performs time series predictions of the month-to-month percent changes in people partially vaccinated.

time_percent_change_vaccination_t = all_state_by_month[['Percent Change Vaccination']].iloc[3:10]
time_percent_change_vaccination_t_minus_one = all_state_by_month[['Percent Change Vaccination']].iloc[2:9]


time_model_percent_change_vacc = LinearRegression().fit(time_percent_change_vaccination_t_minus_one[['Percent Change Vaccination']], time_percent_change_vaccination_t['Percent Change Vaccination'])
time_model_percent_change_predict_vacc = time_model_percent_change_vacc.predict(all_state_by_month[['Percent Change Vaccination']].iloc[2:])
sns.lineplot(np.arange(2,10), time_model_percent_change_predict_vacc)
plt.title('Time Series Predictions of Month to Month Percent Changes in People Partially Vaccinated')
plt.xlabel('Month')
plt.ylabel('Percent Change')
```
![image](https://github.com/user-attachments/assets/06dac74e-3da2-46f1-9b36-fb54fc4f2054)

In the second application, depicted below, I utilized the predictions generated by the linear regression model, specifically between the percentage change in deaths and the percentage change in partial vaccination. These predictions were then employed as predictors for the time series analysis. As illustrated below, the resulting plots exhibit significant disparities, suggesting a probable absence of correlation between death rates and vaccination rates.

```python
# This code generates time series predictions of month-to-month percent changes in people partially vaccinated using predictions from a model based on the percent change in deaths versus the percent change partially vaccinated 

vacc_v_death_X = (all_state_by_month[['Percent Change Death']].iloc[2:])
vacc_v_death_y = all_state_by_month['Percent Change Vaccination'].iloc[2:]

vacc_vs_death_month_model = LinearRegression().fit(vacc_v_death_X, vacc_v_death_y)
vacc_v_death_predict =  vacc_vs_death_month_model.predict(all_state_by_month[['Percent Change Death']].iloc[2:])
vacc_v_death_predict_df = pd.DataFrame(vacc_v_death_predict)
time_model_percent_change_vacc_vs_death = time_model_percent_change_vacc.predict(vacc_v_death_predict_df[[0]])
sns.lineplot(np.arange(2,10), time_model_percent_change_vacc_vs_death)
```

![image](https://github.com/user-attachments/assets/b7edbd01-aed3-4eea-b1a4-f271b390df31)

For my second improvement, I extended the same approach to incorporate day-to-day data. To achieve this, I conducted a linear regression analysis, fitting the total number of deaths against the population partially vaccinated. Concurrently, I developed a time series model wherein I applied linear regression to the partially vaccinated population data, comparing it with its own values from the preceding day, establishing our baseline model.

Subsequently, I utilized this baseline model to predict two scenarios: a) utilizing solely the partially vaccinated data, and b) employing an array generated by inputting the total death data into our linear regression model for total deaths against the population partially vaccinated. I then generated plots for both scenarios and observed that while the prediction derived solely from the partially vaccinated data exhibited a slightly parabolic shape, the model predicted using the output from the regression model of total deaths against the population partially vaccinated displayed a more linear trend.

My decision to focus on total deaths and the population partially vaccinated rather than their percentage counterparts stemmed from my belief that daily percentage fluctuations would introduce significant volatility, potentially hindering valuable insights. Thus, by analyzing total counts, I aimed to capture more stable trends over time.

```python
# The code fits a linear regression model to predict the number of people partially vaccinated based on the total deaths
# It then predicts the number of people partially vaccinated using this model and plots the time series of these predictions over the dates provided in the dataset

time_t = all_state[['People_Partially_Vaccinated']].iloc[1:]
time_t_minus_one = all_state[['People_Partially_Vaccinated']].iloc[:-1]
time_model = LinearRegression().fit(time_t_minus_one[['People_Partially_Vaccinated']], time_t['People_Partially_Vaccinated'])
death_vs_vacc_model_time = LinearRegression().fit(all_state[['tot_death']], all_state['People_Partially_Vaccinated'])
death_vs_vacc_array = death_vs_vacc_model_time.predict(all_state[['tot_death']])
death_vs_vacc_df = pd.DataFrame(death_vs_vacc_array)
time_model_predict_with_death = time_model.predict(death_vs_vacc_df[[0]])
sns.lineplot(all_state['Date'], time_model_predict_with_death)
plt.title('Time Series Model of the Number of People Partially Vaccinated Using the Predictions from the Model: Total Deaths vs. People Partially Vaccinated')
plt.ylabel('Number of People')
```

![image](https://github.com/user-attachments/assets/3a960d49-14a6-48ed-b732-434412d4cd54)

```python
# This code plots a time series model predicting the number of people partially vaccinated based on the previous number of people partially vaccinated

time_model_predict = time_model.predict(time_t_minus_one[['People_Partially_Vaccinated']])
sns.lineplot(all_state['Date'].iloc[1:], time_model_predict)
plt.title('Time Series Model of the Number of People Partially Vaccinated')
plt.ylabel('Number of People')
```

![image](https://github.com/user-attachments/assets/bd2e6a19-3d5f-4157-a692-2518c3221dbd)

## Challenges I Encountered

I faced challenges with my initial hypothesis. While I initially believed there was a compelling insight within the data, it primarily drew features directly from the provided datasets. After receiving feedback on my design document, I brainstormed ways to enhance the datasets, either by creating new features or sourcing additional datasets. Subsequently, I hypothesized that significant increases in death rates correlate with subsequent increases in vaccination rates. This led me to implement time-based modeling in my exploratory data analyses (EDAs), analyzing trends over time using supplementary CDC datasets.

Another challenge arose when selecting appropriate visualizations for the data. Initially, I attempted to use a heatmap to depict the proportions of individuals who consistently wear masks versus those who never do, instead of exploring various combinations of these features. This issue resolved itself after I revised the hypothesis, enabling me to more effectively identify the most suitable visualizations for my objectives.

In the second phase of the project, one of my initial challenges was finding a dataset relevant to my hypothesis. I initially selected a dataset containing death counts for every county in the United States, totaling around 2.4 million rows. However, upon importing it into DataHub, I encountered kernel crashing issues due to the dataset's size. Subsequently, I opted for a CDC dataset, which provided a more manageable amount of data. This dataset included the essential information I required: dates and associated death counts. Incorporating this external dataset necessitated additional data cleaning and organization to ensure smooth data extrapolation for my modeling and hypothesis testing. Specifically, I adjusted the time interval from daily to monthly, as daily updates were unlikely to reflect changes in response to death rates, given the impracticality of individuals monitoring COVID statistics daily. Additionally, this dataset provided aggregate data for entire states, prompting me to perform principal component analysis (PCA) on the states to select those that offered the most comprehensive insight into our problem space.

## Results

My graphs consistently validate my hypothesis across the four different states I chose for analysis. They consistently demonstrate that the rates of individuals partially vaccinating tend to spike following an increase in deaths. This trend is particularly noticeable just before the fifth month for partially vaccinated data in all four states. I interpret the percent change in vaccination as reflecting the number of individuals receiving their first dose of any given vaccine, as opposed to the percent change in full vaccination, which conceptually represents a cumulative sum of vaccinations. Consequently, as the majority of individuals get vaccinated relatively quickly, and fewer people remain to be vaccinated, the percent change for partial vaccination begins to decline, resulting in an inverse logarithmic-shaped curve. However, in all cases (i.e., all the states selected based on PCA), whenever there is a spike in death rates, there is an immediate subsequent increase in the rate at which individuals are vaccinated, creating a distinct peak in an otherwise smooth curve. In summary, any spike in the percent change in the number of deaths for a given state leads to a noticeable increase in the percent change of individuals getting vaccinated, consequently resulting in a slight, yet unmistakable, rise in the expectedly decreasing rate of full vaccination.

My second exploratory data analysis (EDA) further reinforced this analysis by revealing that only partially vaccinated data deviated from the anticipated trend of a consistent increase in death/vaccination rates. In fact, the highest peak value from my second EDA graph for the number of people partially vaccinated per capita occurs on April 15th, 2021, coinciding roughly with the exact date when I observed a shift from a downward trend to an upward trend in partial vaccination percentage change rates for all four states in my initial EDA. This serves as evidence that this period marks an unusual increase in partial vaccinations, likely attributed to spikes in death rates occurring somewhere between the second and fourth months, as observed in each state.

## Future Work

An intriguing expansion of my current exploration would involve focusing specifically on the timeframes preceding the announcement of COVID variants and the subsequent months thereafter. I am curious to observe how these variants affected death rates and vaccination rates. Another compelling area for further investigation, following my analysis of anti-vaccine sentiments, would be booster hesitancy as booster shots became more prevalent and widely accessible to the public. I am interested in exploring how individuals' willingness to receive booster shots changed/may change in response to the announcement and prevalence of new variants, as well as the potential increase in contagiousness and severity associated with contracting the mutated virus.

Many of the data science techniques I've learned could prove invaluable in establishing informative correlations and associations between these questions. These inquiries are likely to arise in the future as the status of the pandemic continues to undergo changes and evolve alongside global developments.
