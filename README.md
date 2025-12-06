<div align="center">

# 📊 Customer Cohort Retention & Lifetime Value Analysis  
### SQL | Power BI | Cohort Analysis + LTV Modeling  

<img src="https://img.shields.io/badge/Status-Completed-brightgreen" />
<img src="https://img.shields.io/badge/SQL-PostgreSQL-blue" />
<img src="https://img.shields.io/badge/BI-Power%20BI-yellow" />

---

📌 A data analytics project measuring **customer retention and lifetime value growth** using SQL + Power BI.

</div>

---

## 🔍 Project Overview

This project analyzes customer behavior over time using **Cohort retention modeling** and **LTV curve analysis**.

It tracks:

✔ How customer cohorts perform over months  
✔ When churn happens  
✔ How much value returning customers contribute  

The outcome is a Power BI dashboard showing retention patterns and lifetime value progression.

---

## 🧠 Business Questions Answered

- How many customers return after their first purchase?
- What percentage of users return after 1–12+ months?
- Which monthly cohorts are the strongest performers?
- What is the **average retention rate across cohorts?**
- How does **lifetime value evolve** over time?

---

## 🛠 Tools & Technologies Used

| Component       | Technology            |
|----------------|------------------------|
| Data storage   | PostgreSQL            |
| Transformations | SQL Views / CTEs      |
| Visualization  | Power BI              |
| Language       | SQL + DAX (minor)     |

---

## 🗂 Dataset & Data Model

### Key fields used:

- `customer_id`
- `order_date`
- `revenue`
- `cohort_month`
- `period_number`
- `customers_in_period`
- `lifetime_value`

## 📂 Data Model Flow

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




