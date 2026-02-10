0) Quick context checks
SELECT CURRENT_DATABASE(), CURRENT_SCHEMA(), CURRENT_ROLE(), CURRENT_WAREHOUSE();

1) Row count (sanity check)
SELECT COUNT(*) AS total_rows
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO;

2) Column preview
SELECT *
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
LIMIT 10;

3) Distinct churn labels (VERY IMPORTANT)
SELECT CHURN, COUNT(*) AS customers
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY CHURN
ORDER BY customers DESC;

4) Overall churn rate (%)
SELECT
  COUNT(*) AS total_customers,
  SUM(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)) AS churned_customers,
  ROUND(100.0 * AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)), 2) AS churn_rate_percent
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO;

5) Churn rate by Contract
SELECT
  CONTRACT,
  COUNT(*) AS customers,
  SUM(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)) AS churned_customers,
  ROUND(100.0 * AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)), 2) AS churn_rate_percent
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY CONTRACT
ORDER BY churn_rate_percent DESC;

6) Churn rate by Internet Service
SELECT
  INTERNETSERVICE,
  COUNT(*) AS customers,
  SUM(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)) AS churned_customers,
  ROUND(100.0 * AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)), 2) AS churn_rate_percent
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY INTERNETSERVICE
ORDER BY churn_rate_percent DESC;

7) Churn rate by Payment Method
SELECT
  PAYMENTMETHOD,
  COUNT(*) AS customers,
  SUM(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)) AS churned_customers,
  ROUND(100.0 * AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)), 2) AS churn_rate_percent
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY PAYMENTMETHOD
ORDER BY churn_rate_percent DESC;

8) Tenure buckets + churn rate
SELECT
  CASE
    WHEN TENURE < 6 THEN '0-5'
    WHEN TENURE < 12 THEN '6-11'
    WHEN TENURE < 24 THEN '12-23'
    WHEN TENURE < 48 THEN '24-47'
    ELSE '48+'
  END AS TENURE_BUCKET,
  COUNT(*) AS customers,
  SUM(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)) AS churned_customers,
  ROUND(100.0 * AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)), 2) AS churn_rate_percent
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY TENURE_BUCKET
ORDER BY TENURE_BUCKET;

9) Monthly charges summary by churn status
SELECT
  CHURN,
  COUNT(*) AS customers,
  ROUND(AVG(MONTHLYCHARGES), 2) AS avg_monthly_charges,
  ROUND(MIN(MONTHLYCHARGES), 2) AS min_monthly_charges,
  ROUND(MAX(MONTHLYCHARGES), 2) AS max_monthly_charges
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY CHURN
ORDER BY customers DESC;

10) Multi-factor churn analysis (Contract x InternetService) for Heatmap
SELECT
  CONTRACT,
  INTERNETSERVICE,
  COUNT(*) AS customers,
  ROUND(100.0 * AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)), 2) AS churn_rate_percent
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
GROUP BY CONTRACT, INTERNETSERVICE
ORDER BY churn_rate_percent DESC;

11) Identify "high-risk" segment (example business rule)
-Month-to-month + high charges + low tenure

SELECT
  *
FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
WHERE CONTRACT = 'Month-to-month'
  AND MONTHLYCHARGES > 70
  AND TENURE < 12;

12) Rank segments by churn rate (window function example)
WITH contract_rates AS (
  SELECT
    CONTRACT,
    AVG(IFF(UPPER(TRIM(CHURN)) IN ('CHURNED','YES'), 1, 0)) AS churn_rate
  FROM SNOWFLAKE_LEARNING_DB.PUBLIC.TELCO
  GROUP BY CONTRACT
)
SELECT
  CONTRACT,
  ROUND(100.0 * churn_rate, 2) AS churn_rate_percent,
  RANK() OVER (ORDER BY churn_rate DESC) AS churn_rank
FROM contract_rates
ORDER BY churn_rank;
