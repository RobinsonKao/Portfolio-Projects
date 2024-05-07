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

![pca](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/7f7868f3-197e-45b5-8103-858dfa1002e8)

To structure the data appropriately, I began by converting the columns into proper datetime objects and subsequently merged the data based on states and dates. Following this, I generated additional columns to calculate the percentage changes in both partial and full vaccinations separately, as well as the month-to-month percentage change in deaths.

![datetime](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/5dbcd547-7d85-407b-9a74-080b154ac272)

I opted for calculating percentage changes as it offers a more visually interpretable representation compared to per capita increases. During the initial exploration, I observed that death rates were significantly lower than vaccination rates across all datasets. Consequently, the per capita approach in my first iteration of this EDA yielded minimal values, making it challenging to discern correlations. By transitioning to percentage changes, this effectively mitigated the disparity in per capita values, scaling the data uniformly. As a result, the correlation within the data became distinctly clear through percentages.

![New York](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/b939ec08-5ee0-404e-8811-c7e1af358647)

![Colorado](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/76ee3bdf-5429-4f78-91b4-9e7f5bfac8ec)

![Texas](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/218fdc98-7ee3-4e2b-b8d7-bdf74a6cd60d)

![Idaho](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/d8d605e0-ccf4-49cc-9812-8798f7537fbd)

In the end, I opted to aggregate the data on a month-to-month basis rather than a day-to-day basis because I observed that percentage changes on a daily scale exhibited excessive fluctuations, making trend identification challenging. Aggregating month-to-month facilitated clearer trend visualization, as it smoothed out fluctuations and highlighted more discernible patterns.

## Exploratory Data Analysis Part 2

For my second exploratory data analysis (EDA), I opted to aggregate daily total per capita death and vaccination rates across the entire United States. I chose this approach deliberately as it offers a distinct aggregation method from my initial EDA. My hypothesis posited that such nationwide aggregation, coupled with daily comparisons, would afford us a fresh perspective compared to our previous analysis. By conducting EDA in this manner, I aimed to identify anomalies deviating from expected consistent upward trends. The anticipated pattern entails death rates, vaccinations, and partial vaccinations increasing at a relatively constant pace, making any deviations potentially indicative of significant insights pertinent to the hypothesis.

![eda2 1](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/c1ccd84e-8138-48e1-a083-b7d147c4bf7d)

![eda2 2](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/22b670ad-3f62-4abb-8054-03401beaa629)

![eda2 3](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/58d75bd5-708e-46ef-a24c-dd206965d853)

## Models

In my model, I conducted a linear regression analysis between the month-to-month percentage changes in death rates and vaccination rates. The resulting root mean square error (RMSE) of 0.69 was relatively large compared to the dataset's measurements, which typically hovered around 1.0, indicating a weak correlation between the variables. This inference is supported by a graphical representation illustrating the disparity between my predicted percentage changes in vaccination rates and the actual percentage changes observed from February 2021 to September 2021.

![orange](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/86091242-b4f1-453a-b5a2-a2bd91ff61b6)

Furthermore, I plotted the mean squared error (MSE) to underscore the extent of the model's inaccuracies relative to the actual values.

![MSE](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/301bcfba-0792-498b-8e6e-89dc7b39d3e8)

The majority of the plot illustrates the mean squared error (MSE) exceeding 0, particularly notable in the second month. This discrepancy vividly illustrates the deviation between my model's predictions and the actual values, rendering it unnecessary to mentally compare the two plots directly. Given that the percentage differences are generally small, averaging around 1%, an MSE visibly surpassing 2.5 strongly indicates a lack of correlation between changes in death rates and changes in vaccination rates.

## Model Improvement

To enhance my model's performance, I introduced several adjustments, including the integration of time series modeling. I explored this approach with both monthly and daily data. For the monthly data, I fitted the month-to-month percentage changes in deaths to the month-to-month percentage changes in vaccinations. Subsequently, I developed a time series model to assess the progression of month-to-month vaccination rate changes. This time series model was employed twice. Initially, I utilized it to predict the next month's percentage change as shown below.

![percent](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/d889688e-7823-49a9-8ff2-976774d20614)

In the second application, depicted below, I utilized the predictions generated by the linear regression model, specifically between the percentage change in deaths and the percentage change in partial vaccination. These predictions were then employed as predictors for the time series analysis. As illustrated below, the resulting plots exhibit significant disparities, suggesting a probable absence of correlation between death rates and vaccination rates.

![fix](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/4c7fb7ce-e0c1-43b6-8f61-75a9878fdba0)


For my second improvement, I extended the same approach to incorporate day-to-day data. To achieve this, I conducted a linear regression analysis, fitting the total number of deaths against the population partially vaccinated. Concurrently, I developed a time series model wherein I applied linear regression to the partially vaccinated population data, comparing it with its own values from the preceding day, establishing our baseline model.

Subsequently, I utilized this baseline model to predict two scenarios: a) utilizing solely the partially vaccinated data, and b) employing an array generated by inputting the total death data into our linear regression model for total deaths against the population partially vaccinated. I then generated plots for both scenarios and observed that while the prediction derived solely from the partially vaccinated data exhibited a slightly parabolic shape, the model predicted using the output from the regression model of total deaths against the population partially vaccinated displayed a more linear trend.

My decision to focus on total deaths and the population partially vaccinated rather than their percentage counterparts stemmed from my belief that daily percentage fluctuations would introduce significant volatility, potentially hindering valuable insights. Thus, by analyzing total counts, I aimed to capture more stable trends over time.

![snip](https://github.com/RobinsonKao/Portfolio-Projects/assets/112150963/53f12a67-8767-4cc1-8a64-7415ed04ad76)

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
