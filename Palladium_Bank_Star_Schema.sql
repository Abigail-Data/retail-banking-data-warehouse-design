-- Palladium Bank Retail Banking Dimensional Star Schema Design
-- Includes SCD Type 2 Dimensions, Fact Table, Aggregation Table and Performance Indexes


-- DIMENSION TABLE: DATE DIMENSION

CREATE TABLE Dim_Date (
    Date_Key INT PRIMARY KEY,
    Full_Date DATE,
    Day_Number INT,
    Month_Number INT,
    Month_Name VARCHAR(20),
    Quarter_Number INT,
    Year_Number INT
);


-- DIMENSION TABLE: CUSTOMER DIMENSION

CREATE TABLE Dim_Customer (
    Customer_Key INT PRIMARY KEY IDENTITY(1,1),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Tier VARCHAR(20),
    Effective_Date DATE,
    End_Date DATE,
    Is_Current CHAR(1)
);


-- DIMENSION TABLE: BRANCH DIMENSION

CREATE TABLE Dim_Branch (
    Branch_Key INT PRIMARY KEY IDENTITY(1,1),
    Branch_ID VARCHAR(20),
    Branch_Name VARCHAR(100),
    State VARCHAR(50),
    Effective_Date DATE,
    End_Date DATE,
    Is_Current CHAR(1)
);


-- DIMENSION TABLE: PRODUCT DIMENSION

CREATE TABLE Dim_Product (
    Product_Key INT PRIMARY KEY IDENTITY(1,1),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(100),
    Product_Type VARCHAR(50)
);


-- DIMENSION TABLE: CHANNEL DIMENSION

CREATE TABLE Dim_Channel (
    Channel_Key INT PRIMARY KEY IDENTITY(1,1),
    Channel_Name VARCHAR(50)
);


-- FACT TABLE: TRANSACTION FACTS

CREATE TABLE Fact_Transactions (
    Fact_ID INT PRIMARY KEY IDENTITY(1,1),
    Txn_ID VARCHAR(30),
    Txn_Type VARCHAR(50),
    Date_Key INT,
    Customer_Key INT,
    Branch_Key INT,
    Product_Key INT,
    Channel_Key INT,
    Amount DECIMAL(18,2),
    Balance_After DECIMAL(18,2),

    FOREIGN KEY (Date_Key) REFERENCES Dim_Date(Date_Key),
    FOREIGN KEY (Customer_Key) REFERENCES Dim_Customer(Customer_Key),
    FOREIGN KEY (Branch_Key) REFERENCES Dim_Branch(Branch_Key),
    FOREIGN KEY (Product_Key) REFERENCES Dim_Product(Product_Key),
    FOREIGN KEY (Channel_Key) REFERENCES Dim_Channel(Channel_Key)
);


-- =========================================
-- TABLE PURPOSE COMMENTS
-- =========================================

-- Dim_Date stores calendar attributes for month-on-month,
-- quarter-on-quarter and year-on-year reporting.

-- Dim_Customer stores customer descriptive attributes and
-- supports SCD Type 2 history tracking for customer tier changes.

-- Dim_Branch stores branch geographic information and
-- supports SCD Type 2 for branch detail updates.

-- Dim_Product stores all retail banking product information.

-- Dim_Channel stores transaction channel descriptors.

-- Fact_Transactions stores one row per unique banking transaction
-- and links all dimensions through surrogate keys.



-- PERFORMANCE INDEXES

CREATE INDEX idx_fact_date ON Fact_Transactions(Date_Key);
CREATE INDEX idx_fact_customer ON Fact_Transactions(Customer_Key);
CREATE INDEX idx_fact_branch ON Fact_Transactions(Branch_Key);
CREATE INDEX idx_fact_product ON Fact_Transactions(Product_Key);
CREATE INDEX idx_fact_channel ON Fact_Transactions(Channel_Key);



-- MONTHLY AGGREGATION TABLE

CREATE TABLE Agg_Monthly_Branch_Revenue (
    Agg_ID INT PRIMARY KEY IDENTITY(1,1),
    Branch_Key INT,
    Date_Key INT,
    Total_Transaction_Value DECIMAL(18,2),
    Total_Transaction_Count INT,

    FOREIGN KEY (Branch_Key) REFERENCES Dim_Branch(Branch_Key),
    FOREIGN KEY (Date_Key) REFERENCES Dim_Date(Date_Key)
);