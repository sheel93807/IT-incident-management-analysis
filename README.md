# 📊 Incident Management Analytics Dashboard

A business intelligence project analyzing 24,918 incidents and 141,712 ServiceNow event records using Python, SQL Server, and Power BI.

---

## 🎯 Project Overview

This project explores operational performance within an incident management environment, focusing on:

- SLA Compliance
- Incident Reassignment Activity
- Category Performance
- Assignment Group Effectiveness
- Priority Performance
- Reopen Analysis
- Monthly Operational Trends

The dataset was sourced from the UCI Machine Learning Repository and contains anonymized incident management data extracted from a ServiceNow environment.

---

## 🛠 Tools Used

- Python
- SQL Server
- Power BI
- Jupyter Notebook
- GitHub

---

## 📂 Project Workflow

```text
Raw Incident Data
        ↓
Python Data Cleaning
        ↓
SQL Server Analysis
        ↓
SQL Reporting Views
        ↓
Power BI Dashboard
```

---

## 📈 Dashboard Pages

### 1️⃣ Executive Overview

Provides high level KPI reporting and operational benchmarks.

Dashboard_Screenshots/01_Executive_Overview.png

---

### 2️⃣ Reassignment Analysis

Evaluates how ticket handoffs affect:

- Resolution Hours
- SLA Compliance
- Reopen Rates
- Incident Volume

Dashboard_Screenshots/02_Reassignment_Analysis.png

---

### 3️⃣ Category Performance

Compares service categories based on:

- Incident Volume
- Resolution Performance
- SLA Compliance
- Reopen Rates

Dashboard_Screenshots/03_Category_Performance.png

---

### 4️⃣ Assignment Group Performance

Measures workload and performance across support groups.

Dashboard_Screenshots/04_Assignment_Group_Performance.png

---

### 5️⃣ Priority & Reopen Analysis

Analyzes:

- Priority Performance
- Resolution Trends
- Reopened Incidents
- SLA Outcomes

Dashboard_Screenshots/05_Priority_Reopen_Analysis.png

---

### 6️⃣ Monthly Performance Trends

Tracks:

- Incident Volume
- SLA Compliance
- Resolution Performance
- Reassignment Trends

Dashboard_Screenshots/06_Monthly_Performance_Trends.png

---

### 7️⃣ Data & Methodology

Documents:

- Dataset Metadata
- Source Attributes
- SQL Reporting Views
- Project Methodology
- Dataset Limitations

Dashboard_Screenshots/07_Data_Methodology.png

---

## 🔑 Key Findings

- Incidents with 3+ reassignments averaged **429.20 resolution hours** compared with **94.98 hours** for incidents without reassignment.
- SLA compliance decreased from **77.07%** to **25.00%** as reassignment activity increased.
- Category 46 generated **2,356 incidents** while maintaining only **47.54% SLA compliance**.
- Group 70 handled **7,905 incidents** while maintaining **82.88% SLA compliance**.
- Reopened incidents averaged **457.37 resolution hours** compared with **174.86 hours** for incidents that were not reopened.

---

## 🗄 SQL Reporting Views

The Power BI dashboard was built using seven analytical SQL reporting views:

| View | Purpose |
|--------|--------|
| `vw_Incident_Summary` | Core incident-level dataset used for KPIs and filtering |
| `vw_Reassignment_Impact` | Measures reassignment impact on service performance |
| `vw_Category_Performance` | Category-level operational analysis |
| `vw_Assignment_Group_Performance` | Assignment group performance benchmarking |
| `vw_Priority_Performance` | Priority-based performance analysis |
| `vw_Reopen_Performance` | Reopened vs non-reopened incident analysis |
| `vw_Monthly_Performance` | Monthly operational trend reporting |

---

## 📚 Dataset Information

**Source:** UCI Machine Learning Repository

**Dataset:** Incident Management Process Enriched Event Log

**Event Records:** 141,712

**Unique Incidents:** 24,918

**Original Attributes:** 36

**Reporting Period:** February 2016 – February 2017

The dataset was extracted from an anonymized ServiceNow environment and contains incident lifecycle, assignment, priority, SLA, and operational performance information.

---

Tools: Python • SQL Server • Power BI

📅 Project Completed: October 7, 2026
