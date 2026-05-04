# Retail Banking Data Warehouse Design – Palladium Bank Case Study

## Project Overview
This project presents a dimensional data modelling solution designed for Palladium Bank to improve retail banking analytics performance. The bank previously relied on raw transaction logs for reporting, resulting in slow queries and inconsistent insights. A scalable star schema warehouse was therefore designed to support faster reporting, customer behaviour analysis, branch monitoring, product performance tracking, churn detection, and time-based trend analysis.

## Business Questions Addressed
- Which customer segments generate the most fee income?
- How does transaction behavior vary by branch and channel?
- Are high-value customers reducing activity?
- Which products drive deposits versus withdrawals?

## Deliverables Included
- SQL dimensional star schema design
- Slowly Changing Dimension (SCD Type 2) handling
- ETL / ELT loading strategy
- Data quality and performance recommendations
- Retail banking schema diagram
- Technical design explanation document

## Dimensional Model Components
### Fact Table
- Fact_Transactions

### Dimension Tables
- Dim_Date
- Dim_Customer
- Dim_Branch
- Dim_Product
- Dim_Channel

### Aggregation Table
- Agg_Monthly_Branch_Revenue

## Key Data Engineering Concepts Applied
- Star Schema Design
- Surrogate Keys
- Primary & Foreign Key Relationships
- Slowly Changing Dimensions (Type 2)
- Incremental ETL Loading
- Monthly Partitioning
- Foreign Key Indexing
- Aggregation Layer Design

## Tools Used
- SQL
- dbdiagram.io
- Microsoft Word

## Author
Abigail Alabi
Data Analyst | Data Modelling & Analytics Enthusiast
