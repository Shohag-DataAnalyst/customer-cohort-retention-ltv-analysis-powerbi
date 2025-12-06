CREATE OR REPLACE VIEW vw_customer_first_purchase AS
SELECT
  customer_key,
  MIN(order_date) AS first_order_date,
  DATE_TRUNC('month', MIN(order_date))::date AS cohort_month
FROM vw_sales
GROUP BY customer_key;



SELECT 
	a.customer_key,
	a.first_order_date,
	a.cohort_month,
	b.order_date,
	b.revenue
FROM vw_customer_first_purchase AS a
JOIN vw_sales AS b
ON a.customer_key = b.customer_key
WHERE a.cohort_month = DATE '2021-06-01'
LIMIT 20;



CREATE OR REPLACE VIEW vw_cohort_activity AS 
SELECT 
	fp.customer_key,
	fp.cohort_month,
	DATE_TRUNC('month', s.order_date)::date AS order_month,
	(
		(EXTRACT(YEAR FROM s.order_date) * 12 + EXTRACT(MONTH FROM s.order_date))
		-
		(EXTRACT (YEAR FROM fp.cohort_month) * 12 + EXTRACT (MONTH FROM fp.cohort_month))
	)::INT AS period_number,

	s.revenue
FROM vw_customer_first_purchase AS fp
JOIN vw_sales AS s
ON fp.customer_key = s.customer_key;



CREATE OR REPLACE VIEW vw_cohort_retention_counts AS 
WITH max_period AS (
	SELECT 
		GREATEST(MAX(period_number), 0) AS max_p
	FROM vw_cohort_activity
),
cohort_sizes AS (
	SELECT 
		cohort_month, 
		COUNT(DISTINCT customer_key) AS cohort_size
	FROM vw_customer_first_purchase
	GROUP BY cohort_month
),
raw_counts AS (
	SELECT
		cohort_month,
		period_number,
		COUNT(DISTINCT customer_key) AS customers_in_period
	FROM vw_cohort_activity
	GROUP BY cohort_month, period_number
)

SELECT
	c.cohort_month,
	gs.period_number,
	COALESCE(r.customers_in_period, 0) AS customers_in_period,
   	cs.cohort_size
FROM
  (SELECT DISTINCT cohort_month FROM vw_customer_first_purchase) AS c
CROSS JOIN
  (SELECT generate_series(0, (SELECT max_p FROM max_period)) AS period_number) AS gs
LEFT JOIN raw_counts AS r
  ON r.cohort_month = c.cohort_month
 AND r.period_number = gs.period_number
LEFT JOIN cohort_sizes AS cs
  ON cs.cohort_month = c.cohort_month
ORDER BY c.cohort_month, gs.period_number;




CREATE OR REPLACE VIEW vw_cohort_retention_pct AS
WITH cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_key) AS cohort_size
    FROM vw_customer_first_purchase
    GROUP BY cohort_month
),
activity_counts AS (
    SELECT
        cohort_month,
        period_number,
        COUNT(DISTINCT customer_key) AS customers_in_period
    FROM vw_cohort_activity
    GROUP BY cohort_month, period_number
)
SELECT
    a.cohort_month,
    a.period_number,
    a.customers_in_period,
    cs.cohort_size,
    ROUND(a.customers_in_period::numeric / NULLIF(cs.cohort_size,0), 4) AS retention_pct
FROM activity_counts AS a
JOIN cohort_sizes AS cs
    ON cs.cohort_month = a.cohort_month
ORDER BY cohort_month, period_number;






CREATE OR REPLACE VIEW vw_cohort_ltv AS
SELECT
  cohort_month,
  period_number,
  revenue_in_period,
  cohort_size,
  SUM(revenue_in_period) OVER (PARTITION BY cohort_month ORDER BY period_number
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue,
  ROUND( (SUM(revenue_in_period) OVER (PARTITION BY cohort_month ORDER BY period_number
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)::numeric
       / NULLIF(cohort_size,0)), 2) AS avg_ltv_per_customer
FROM vw_cohort_revenue_by_period
ORDER BY cohort_month, period_number;


SELECT cohort_month, period_number, revenue_in_period, cumulative_revenue, avg_ltv_per_customer
FROM vw_cohort_ltv
WHERE cohort_month = (SELECT MIN(cohort_month) FROM vw_customer_first_purchase)
ORDER BY period_number
LIMIT 24;

