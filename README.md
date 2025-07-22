# Cafe Sales Data Project: Data Cleaning & EDA

## Overview

This project involves cleaning and analyzing a cafe sales dataset, ensuring data quality, and extracting business insights.

---

## 1. Raw Data Description

The original dataset contains records of cafe sales transactions.  
Each row is a transaction, with the following columns:

| **Column Name**        | **Type**   | **Description**                                 |
|------------------------|------------|-------------------------------------------------|
| Transaction ID         | VARCHAR    | Unique identifier for each transaction          |
| Item                   | VARCHAR    | Name of the menu item purchased                 |
| Quantity               | INTEGER    | Number of units purchased per transaction       |
| Price Per Unit         | DECIMAL    | Price of a single item in the transaction       |
| Total Spent            | DECIMAL    | Total amount spent in the transaction           |
| Payment Method         | VARCHAR    | Payment type (e.g., CASH, CARD, etc.)           |
| Location               | VARCHAR    | Sale location (e.g., instore, takeaway)         |
| Transaction Date       | VARCHAR/DATE| Date and time of the transaction               |

**Note:**  
- Some columns initially contained `NULL`, `'Unknown'`, `'ERROR'`, or blank values.
- Dates were sometimes in various formats or invalid.
- Numeric fields occasionally had non-numeric values.

---

## 2. Data Cleaning Process

### Objectives

- **Remove or correct** missing, invalid, or inconsistent entries.
- **Standardize** data types for reliable analysis.
- **Validate** calculations (e.g., `Total Spent = Quantity × Price Per Unit`).
- **Ensure** transactional record uniqueness.

### Steps Performed

#### a. Handling Missing & Invalid Values

- Set `NULL` for `'Unknown'`, `'ERROR'`, and blank values in all text fields (`Item`, `Payment Method`, `Location`).
- Ensured `Transaction ID` and `Transaction Date` had no missing or invalid entries; set `NULL` if found.
- Enforced numeric values in `Quantity`, `Price Per Unit`, and `Total Spent`; set non-numeric or error values to `NULL`.

#### b. Data Type Enforcement

- **Converted** `Transaction Date` from text to `DATE` after cleaning invalid formats.
- **Set numeric columns** to appropriate data types for math operations.

#### c. Validation & Consistency Checks

- **Verified** that `Total Spent = Quantity × Price Per Unit` where all values were present; flagged discrepancies in a new column.
- **Checked** for duplicate `Transaction ID` values to confirm uniqueness.

#### d. Flagging & Documentation

- **Added columns** (e.g., `is_invalid`, `validate_transaction`) to mark rows needing manual review.
- **Documented** cleaning steps and data quality rules for reproducibility.

---

## 3. Exploratory Data Analysis (EDA)

### Goals

- **Understand** sales trends, product performance, channel differences, and payment preferences.
- **Generate** actionable business insights.

### Key Analyses Conducted

- **Sales Over Time:** Computed monthly and yearly totals to visualize seasonality and growth.
- **Product Performance:** Ranked items by total quantity and revenue.
- **Channel & Location Analysis:** Compared instore vs. takeaway sales and evaluated sales by location.
- **Payment Preferences:** Analyzed usage of payment methods and their revenue.
- **KPI Summary:** Calculated **Total Sales**, **Number of Transactions**, and **Average Transaction Value** as dashboard cards.
- **Data Quality Metrics:** Tracked counts of missing, flagged, or manually reviewed records for ongoing quality assurance.

---

## 4. Dashboard Construction

- **Created unified dashboards** in Tableau with:
  - **Trend charts** (time series line charts) for sales over time. Provides a clear view of seasonality and monthly performance consistency, included transaction counts, making it easy to spot trends or dips in sales.
  - **Bar charts** for top-selling items and Coffee, Juice, and Cake have the highest quantities sold, reflecting their popularity.
    This is useful for inventory and procurement planning.
  - **Column charts** for Location wise splits. In-store and takeaway revenues are fairly balanced, allowing easy channel comparison.
  - **Bar charts** for Revenue by item. Salad is the top revenue generator, followed by Sandwiches and Smoothies.
    Items like Cookie and Tea contribute less to overall revenue.
    <img width="1892" height="993" alt="Screenshot 2025-07-23 021722" src="https://github.com/user-attachments/assets/2459b3b3-21a6-4686-83a6-71d55f61b35f" />


**This README is the central reference for both the data’s structure, the cleaning workflow, and the analytical steps applied. It ensures reproducibility and transparency for all project stages.**
