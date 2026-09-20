# Olist E-Commerce Sales & Customer Analytics

**End-to-end SQL + Power BI analytics project** analyzing 99K+ orders from the Olist Brazilian E-Commerce dataset — covering sales, customers, sellers, products, and delivery performance.

![Status](https://img.shields.io/badge/status-completed-brightgreen)
![SQL](https://img.shields.io/badge/PostgreSQL-SQL-blue)
![BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow)

---

## 📌 Project Summary

This project simulates a real-world business analytics workflow: taking raw e-commerce data, validating and analyzing it in **PostgreSQL/SQL**, then building an **interactive Power BI dashboard** to surface actionable insights for sales, customer, seller, and delivery performance.

It was built to demonstrate practical, job-ready skills for **Data Analyst, Business Analyst, and BI Analyst** roles — from writing production-style SQL to designing executive-level dashboards.

---

## 🔑 Key Results at a Glance

| Metric | Value |
|---|---|
| Total Revenue | **$13.59M** |
| Total Orders | **98,666** |
| Average Order Value | **$137.75** |
| Total Customers | **95,420** |
| Repeat Customers | **2,997** |
| Total Sellers | **~3,095** |
| Total Products | **~32,951** |
| Late Delivery Rate | **7.91%** |

---

## 🛠️ Tools & Technologies

`PostgreSQL` · `SQL` · `Power BI` · `Git` · `GitHub`

---

## 🔄 Workflow

```
Raw CSV Data → PostgreSQL → Data Quality Validation → SQL Business Analysis
→ Analytical SQL Views → Power BI Dashboard → Business Insights
```

---

## 📊 What's Included

### SQL Analysis (50 Business Questions)
Organized into 5 core business areas plus a dedicated data-quality file:

1. **Sales Analysis** — revenue trends, top products, revenue by state/category, AOV
2. **Customer Analysis** — customer segmentation, repeat customers, top spenders by state
3. **Seller Analysis** — seller revenue, order volume, freight cost, revenue contribution
4. **Delivery & Operations** — delivery times, late-order rates, estimated vs. actual delivery
5. **Product & Category Analysis** — category revenue, growth trends, category ranking
6. **Data Quality Validation** — missing values, duplicates, referential integrity checks

### 11 Production-Style SQL Views
Reusable analytical views (e.g. `vw_executive_kpis`, `vw_monthly_revenue`, `vw_seller_summary`) built to feed Power BI directly — creating a clean separation between raw data and reporting layer.

### Power BI Dashboard (4 Pages)
- **Executive Overview** — top-line KPIs and trends for leadership
- **Customer & Sales Analysis** — customer behavior and geographic patterns
- **Seller Performance** — seller rankings, revenue contribution, freight costs
- **Product & Operations** — category performance and delivery operations

---

## 💡 Sample Insight

> November 2017 was a peak month, generating **over $1.01M** in product revenue alone — highlighted directly in the Executive Overview dashboard page.

---

## 📁 Repository Structure

```
olist-ecommerce-analytics/
├── README.md
├── data/                          # Olist CSV datasets
├── sql/
│   ├── 01_sales_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_seller_analysis.sql
│   ├── 04_delivery_operations.sql
│   ├── 05_product_category_analysis.sql
│   ├── 06_data_quality_validation.sql
│   └── views/                     # 11 analytical SQL views
├── powerbi/
│   └── Olist_Ecommerce_Sales_Customer_Analytics.pbit
├── screenshots/
└── insights/
```

---

## 🧠 Skills Demonstrated

**SQL:** SELECT, JOINs, subqueries, CTEs, CASE statements, window functions (LAG, ranking), date functions, aggregate functions, GROUP BY / HAVING

**PostgreSQL:** database design, multi-table analysis, data quality validation, analytical view creation, business metric calculation

**Power BI:** KPI cards, bar/column/line charts, donut & pie charts, treemaps, scatter plots, gauges, maps, dashboard formatting

**Version Control:** Git & GitHub — repository management, commits, branching

---

## ❓ Business Questions Answered

- How much revenue did the business generate, and how does it trend over time?
- Which categories, states, and products drive the most revenue?
- Who are the highest-spending and most frequent customers?
- Which sellers generate the most revenue and orders?
- What percentage of deliveries are late, and by how much?
- Which product categories are growing or declining?

*(Full list of 50+ questions available in the `/sql` folder.)*

---

## 👤 Author

**Kartick Pal**
B.Tech — Computer Science & Engineering
