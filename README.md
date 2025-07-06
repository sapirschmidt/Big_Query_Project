# SQL Mini-Project — BigQuery Practice  
*A concise, skills-oriented portfolio piece*

## 1. Project Purpose
Demonstrate breadth in analytical SQL by solving 15 progressively-harder business questions on a synthetic dataset hosted in Google BigQuery.  
The README presents:

* the data model and business context  
* questions tackled and SQL concepts covered  
* instructions to reproduce queries and verify results  
* directions for turning the work into a publishable portfolio artifact

## 2. Dataset Overview
Dataset ID : **`sql_tutorial`** (in your GCP project)  
All tables are standard‐typed and partition-friendly.

| Table | Key Columns | Brief Description |
|-------|-------------|-------------------|
| `orders`     | `OrderID`, `OrderDate`, `CustomerID`, `ShipType`, `ShipDuration`, `WeightKg` | Shipment history 2018-2020 |
| `customers`  | `CustomerID`, `Country`, `Segment`         | Basic customer master |
| `employees`  | `EmployeeID`, `Title`, `Gender`, `HireDate`, `ReportsTo` | Org chart & HR attributes |
| `basketball` | `PlayerID`, `Team`, `HeightCm`, `Position` | Demo sports slice |
| `dogs`       | `DogID`, `OwnerName`, `Gender`, `BirthDate`, `IsSterile` | Pet ownership toy data |

> **Storage cost:** < 10 MB total—safe for the BigQuery free tier.

## 3. Business Questions & SQL Techniques

| # | Question (business wording) | Key SQL technique(s) |
|---|-----------------------------|----------------------|
| 1 | Count 2019 orders by `ShipType`. | `GROUP BY`, `DATE_TRUNC` |
| 2 | Avg. height and tallest player per basketball team. | `GROUP BY`, `MAX`, `HAVING` |
| 3 | Cities employing ≥ 3 workers. | `GROUP BY`, `COUNT` |
| 4 | Top-5 countries by shipped weight. | `JOIN`, `ORDER BY`, `LIMIT` |
| 5 | Each employee’s order count vs. departmental mean. | window `AVG()` |
| 6 | Gender breakdown in sales roles. | conditional aggregation |
| 7 | Customers with no 2019 orders. | `LEFT JOIN`, `IS NULL` |
| 8 | Late-shipment ratio per `ShipType`. | CTE, `CASE` logic |
| 9 | Oldest dog age & avg. dogs per owner. | `MAX`, `AVG` |
| 10| Longest streak of identical `ShipType`. | `LAG`, window gaps |
| 11| Delivery-performance NTILE score (top-20 %). | `NTILE`, quarter partition |
| 12| `ARRAY` of intact dogs by gender. | `ARRAY_AGG`, `ARRAY_LENGTH` |
| 13| Re-assign null `ReportsTo` to CEO (ID 18). | `UPDATE … WHERE` |
| 14| Identify top-10 % longest-tenured staff. | `DATE_DIFF`, `PERCENT_RANK` |
| 15| Monthly pivot of shipped weight by `ShipType`. | `PIVOT` or `CASE-SUM` |

## 4. Repository Layout
/sql-mini-project/
├─ README.md ← this file
├─ /sql/
│ ├─ answers.sql ← your final, commented solutions
│ └─ validation_snippets.sql
└─ /docs/
├─ results_screenshots/ ← optional query result captures
└─ summary.md ← insights & reflections

markdown
Copy
Edit

## 5. How to Reproduce

1. **Clone** the repository (private or public).  
2. **Create** or select a GCP project → enable BigQuery.  
3. **Upload** the provided `.sql` DDL script (or your own) to create `sql_tutorial` tables.  
4. In the BigQuery console or `bq` CLI, run:  
   ```bash
   # Set default project & location if needed
   bq query --use_legacy_sql=false < sql/answers.sql
Each query is wrapped in a comment header so you can execute them one-by-one.
5. Validate results with the snippets in /sql/validation_snippets.sql (makes use of small LIMIT 10 prints and checksums).

Optional – Hosted Notebook
Spin up a Colab with the google-cloud-bigquery Python client to run and chart outputs for a more visually appealing portfolio page.

6. Turning Results into a Portfolio Story
Narrative – In /docs/summary.md synthesize findings (e.g., late-shipment rate 7 %, longest Express streak = 5 orders).

Screens – Capture result tables or build a simple Looker Studio dashboard.

Link – Add the GitHub repo URL and selected screenshots to your website / LinkedIn “Featured” section.

7. Prerequisites
Google Cloud account (BigQuery).

Basic familiarity with ANSI SQL; queries are Standard SQL-compliant.

For DML (#13) you need BigQuery Write permissions.

8. Contact
Questions or suggestions? Open an issue or connect on LinkedIn.

License: MIT — feel free to adapt for your own educational use.
