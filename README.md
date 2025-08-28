# 🎓 Student Database Analysis using SQL

## 📌 Project Overview
SQL project for analyzing student performance data using **MySQL** with tables, queries, and ER diagram.  
The database contains tables for students, subjects, attendance, and grades.  
SQL queries are written to analyze performance through **joins, aggregations, subqueries, and views**.

---

## 🛠️ Technologies Used
- MySQL
- SQL
- MySQL Workbench

---

## 📂 Project Files
- `student_analysis.sql` → Contains:
  - Database schema (students, subjects, attendance, grades)
  - Sample data
  - SQL queries for analysis
  - A view for consolidated student performance
- `er-diagram.png` → Entity Relationship Diagram of the database

---

## 🚀 How to Run
1. Open **MySQL Workbench**.
2. Go to **Server → Data Import → Import from Self-Contained File**.
3. Select `student_analysis.sql` and import it.
4. Run the queries inside Workbench to view results.

Or use the terminal:
```bash
mysql -u root -p < student_analysis.sql
