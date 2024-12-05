# Bike-Rental-Demand-Prediction

![Bike Sharing](https://your-image-link-here.com/example.png)

**Introduction**

The dataset focuses on hourly bike rental demand in Seoul from 2017 to 2018, analyzing factors that influence the number of bikes rented. As urban bike-sharing programs provide a flexible, eco-friendly, and convenient mobility alternative, effectively managing rental demand is critical. Accurate demand prediction models can enhance urban mobility experiences by reducing waiting times and ensuring availability.

This project leverages Generalized Linear Models (GLMs), specifically Poisson regression, to predict bike rental counts based on various temporal and meteorological factors, supporting the efficient management of bike-sharing systems.

**Poisson Regression**

Poisson regression is a statistical model designed for count data, where the dependent variable represents the number of events occurring within a specific time or space interval. The model uses a logarithmic link function to relate the expected value of the dependent variable to the independent variables.

**Dataset Overview**

The data was acquired from the UCI Machine Learning Repository: [Seoul Bike Sharing Demand](https://archive.ics.uci.edu/dataset/560/seoul+bike+sharing+demand). It includes 8,760 observations representing hourly bike rental counts and associated meteorological and temporal variables. The dataset contains the following 14 variables:

- **Date**: Specific date (year-month-day).
- **Rented Bike Count**: Number of bikes rented during each hour.
- **Hour**: Hour of the day.
- **Temperature**: Ambient temperature in Celsius.
- **Humidity**: Air humidity percentage.
- **Windspeed**: Wind speed in meters per second.
- **Visibility**: Visibility in meters, indicating clear or obstructed conditions.
- **Dew Point Temperature**: Temperature at which air moisture condenses.
- **Solar Radiation**: Solar radiation measured in megajoules per square meter.
- **Rainfall**: Rainfall in millimeters.
- **Snowfall**: Snowfall in centimeters.
- **Seasons**: Winter, Spring, Summer, or Autumn.
- **Holiday**: Indicates whether the day is a holiday.
- **Functional Day**: Indicates whether the day is a working day.

**Main Steps**

This project follows 8 structured steps:

1. **Descriptive Analysis:** Explore the dataset to summarize statistics and understand key features.
   
2. **Pre-processing:** Clean and prepare the dataset, addressing missing values and scaling features if necessary.

3. **Data Visualization:** Create visual representations to identify patterns, trends, and correlations.

4. **Correlation Analysis:** Evaluate relationships between independent variables and the target variable (bike rentals).

5. **Data Splitting:** Divide the dataset into training and testing sets to ensure unbiased evaluation.

6. **GLM Construction:** Build and fine-tune a Poisson regression model tailored to count-based data.

7. **Model Validation:** Assess model performance using metrics like Mean Absolute Error (MAE) or Root Mean Squared Error (RMSE).

8. **Conclusion:** Summarize findings, including model insights and recommendations for optimizing bike-sharing operations.

**Dataset Link**

[Seoul Bike Sharing Demand Dataset](https://archive.ics.uci.edu/dataset/560/seoul+bike+sharing+demand)

**Outcome**

By accurately modeling the demand for bike rentals, this project contributes to improving resource allocation and enhancing user satisfaction in urban bike-sharing systems.

