<p align="center">
  <img src="https://img.shields.io/badge/Skills-SQL-blue?style=for-the-badge" alt="SQL">
  <img src="https://img.shields.io/badge/Tool-Power%20BI-yellow?style=for-the-badge" alt="Power BI">
  <img src="https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge" alt="Completed">
</p>

---

# 📊 Customer Cohort Retention & Lifetime Value Analysis (SQL + Power BI)

An end-to-end analytics project focused on **customer retention behavior** and **lifetime value (LTV) growth** using cohort analysis.  
Built with **SQL for modeling** and **Power BI for visualization**.

---

## 📁 Project Overview

This project analyzes how customers behave **after their first purchase** using **cohort-based retention analysis** and **lifetime value modeling**.

Instead of looking at customers in aggregate, the analysis groups users into **monthly cohorts** based on their first purchase date and tracks:

- How long customers continue returning
- When churn typically occurs
- How much value customers generate over time
- How newer cohorts compare to older ones

The final result is an interactive Power BI dashboard that clearly visualizes:
- Retention decay
- Long-term customer value
- Cohort performance trends

This project demonstrates the full analytics workflow:

**Raw transactions → SQL cohort modeling → retention & LTV metrics → Power BI dashboard → business insights**

---

## ❓ Business Questions Answered

This project is designed to answer questions such as:

- How many customers return after their **first purchase**?
- What percentage of users return after **1, 3, 6, or 12+ months**?
- Which **monthly cohorts** retain customers the longest?
- What is the **average retention rate** across all cohorts?
- When does **churn most commonly occur**?
- How does **customer lifetime value (LTV)** grow over time?
- Do newer cohorts perform better than older ones?

---

## 🛠 Tools & Technologies

- **SQL (PostgreSQL)**
  - Window functions
  - Date arithmetic
  - Cohort assignment
  - Retention calculations
  - Cumulative revenue modeling

- **Power BI**
  - Cohort heatmaps
  - Line charts for retention & LTV
  - KPI cards
  - Interactive filtering

- **DAX (Light usage)**
  - KPI calculations
  - Formatting and aggregation logic

---

## 🗄️ Dataset & Data Model

The analysis is based on a transactional sales dataset containing:

- `customer_id`
- `order_date`
- `revenue`

From these fields, the project derives:

- **Cohort Month** → customer’s first purchase month  
- **Period Number** → months since first purchase  
- **Customers in Period** → active users per cohort/month  
- **Retention Percentage**  
- **Lifetime Value (LTV)**  

### 📂 Data Model Flow

vw_sales
↓
vw_customer_first_purchase
↓
vw_cohort_activity
↓
vw_cohort_retention_pct
vw_cohort_ltv
↓
Power BI Dashboard

---

## 📁 Project Structure

```bash
customer-cohort-retention-ltv-analysis-powerbi/
│
├── README.md                     # Project documentation
├── cohort_analysis.sql            # Full SQL logic for cohort, retention & LTV modeling
├── cohort_dashboard.pbix          # Power BI dashboard file
├── Screenshots/
│   ├── heatmap.png
│   ├── retention_curve.png
│   ├── ltv_curve.png
│   └── dashboard_full.png
```

---

## 📊 Dashboards Included

### 1️⃣ Cohort Retention Heatmap
- Rows → Cohort month
- Columns → Months since first purchase
- Color intensity → Retention %
- Quickly reveals churn patterns and strong cohort

### 2️⃣ Retention Trend Curve
- Average retention rate over time
- Shows how engagement decays month-by-month

### 3️⃣ Customer Lifetime Value (LTV) Curve
- Cumulative LTV growth by cohort
- Highlights long-term revenue contribution of retained customers

### 4️⃣ KPI Cards
- Average retention rate
- Average lifetime value
- Active cohorts and periods

---

## Key DAX Measures 

```DAX
Average Retention % =
AVERAGE(vw_cohort_retention_pct[retention_pct])

Average LTV =
AVERAGE(vw_cohort_ltv[avg_ltv_per_customer])

Active Customers =
SUM(vw_cohort_activity[customers_in_period])
```

--- 

## How to Run This Project

### ✅ Option 1 — View Dashboard Only
1. Download `cohort_dashboard.pbix
2. Open it in Power BI Desktop
3. Explore all visuals and insights directly

---

### ✅ Option 2 — Rebuild the Full SQL + Power BI Pipeline
1. Ensure you have a transactional sales table with:
   - `customer_id`
   - `order_date`
   - `revenue`
2. Run the SQL script:
```sql
cohort_analysis.sql
```
This creates:
   - Cohort assignment view
   - Retention calculation view
   - Lifetime value (LTV) view
3. Open Power BI Desktop
4. Connect to PostgreSQL
5. Load:
   - `vw_cohort_retention_pct`
   - `vw_cohort_ltv`
6. Refresh the data and explore the dashboard

---

## Dashboard Screenshots

### Cohort Retention Heatmap
