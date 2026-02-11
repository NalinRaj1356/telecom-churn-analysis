# Telecom Customer Churn Analysis & Prediction

## Project Overview

This project analyzes customer churn behavior in a telecom dataset using Snowflake, SQL, Python, and Machine Learning.

The goal was to identify key churn drivers, visualize patterns, and build predictive models to estimate churn probability.


## Tools & Technologies

* Snowflake (Cloud Data Warehouse)
* SQL
* Python
* Pandas
* Matplotlib / Seaborn
* Scikit-Learn

## Workflow

### Data Ingestion

* Uploaded CSV dataset to Snowflake
* Cleaned schema and column names
* Validated data integrity

### SQL Analysis

* Churn rate calculations
* Customer segmentation
* Contract & service analysis
* Tenure behavior exploration

### Visualization

Created charts showing:

* Churn by Contract
* Churn by Internet Service
* Churn by Tenure Bucket
* Monthly Charges Distribution
* Heatmap (Multi-factor churn)
* Boxplot comparisons

### Machine Learning

Models Built:

* Logistic Regression (baseline)
* Random Forest (improved)

Evaluation Metrics:

* Accuracy
* Precision / Recall
* F1 Score
* ROC Curve
* AUC Score

## Key Insights

* Month-to-month contracts show highest churn risk
* Customers with low tenure churn more frequently
* Higher monthly charges correlate with churn
* Fiber optic + short contracts form high-risk segment
* Pricing and onboarding improvements could reduce churn

## Interactive Dashboard

View the live Tableau dashboard here:

https://public.tableau.com/views/Dashboard_17707979717240/Dashboard1?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

This dashboard explores churn behavior across:

* Contract types
* Internet services
* Customer tenure
* Pricing distribution
* Payment methods

## Project Structure

telecom-churn/
notebooks/
sql/
images/
models/
README.md

## Future Improvements

* Hyperparameter tuning
* Feature engineering
* Deployment dashboard
* Real-time churn scoring

## Author

Nalin Raj Ramesh Babu
