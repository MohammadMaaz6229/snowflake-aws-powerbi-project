# AWS S3 → Snowflake → Power BI Data Analytics Project

## 📌 Project Overview

This project demonstrates an end-to-end data analytics pipeline using **Amazon S3, AWS IAM, Snowflake, SQL, and Microsoft Power BI**.

The project starts with raw data stored in an Amazon S3 bucket. The data is then connected to Snowflake using an AWS IAM role and Snowflake Storage Integration. After loading the data into Snowflake, SQL is used for data transformation and analysis. Finally, the transformed data is connected to Power BI to create an interactive dashboard.

## 🛠️ Technologies Used

* **Amazon S3** — Cloud storage for the source dataset
* **AWS IAM** — Role and permissions management
* **Snowflake** — Cloud data warehouse
* **Snowflake SQL** — Data loading and transformation
* **Power BI** — Data visualization and dashboarding

## 🔄 Project Architecture

```text
Raw CSV Data
     │
     ▼
Amazon S3
     │
     ▼
AWS IAM Role
     │
     ▼
Snowflake Storage Integration
     │
     ▼
Snowflake External Stage
     │
     ▼
Snowflake Tables
     │
     ▼
SQL Data Transformation
     │
     ▼
Power BI
     │
     ▼
Interactive Dashboard
```

## 📂 Project Structure

```text
snowflake-aws-powerbi-project/
│
├── README.md
│
├── sql/
│   ├── create_integration.sql
│   ├── create_schema_table.sql
│   ├── create_stage.sql
│   ├── load_data.sql
│   └── data_transformation.sql
│
├── powerbi/
│   └── PowerBI_Project.pbix
│
└── screenshots/
    ├── aws-s3.png
    ├── snowflake.png
    └── powerbi-dashboard.png
```

## ☁️ AWS S3

The raw dataset is stored in an Amazon S3 bucket.

The S3 bucket is connected to Snowflake using a Snowflake Storage Integration and an AWS IAM role.

> **Security:** AWS credentials, passwords, secret keys, and other sensitive information are not included in this repository.

## ❄️ Snowflake

Snowflake is used as the cloud data warehouse for storing and transforming the data.

### Main Snowflake Components

* Storage Integration
* External Stage
* Database
* Schema
* Table
* SQL transformations

The data is loaded from the S3 external stage into Snowflake tables using `COPY INTO`.

Example:

```sql
COPY INTO <DATABASE>.<SCHEMA>.<TABLE>
FROM @<STAGE>
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
)
ON_ERROR = 'CONTINUE';
```

## 📊 Dataset

The dataset contains agricultural and environmental information, including:

* Year
* Location
* Area
* Rainfall
* Temperature
* Soil Type
* Irrigation
* Yield
* Humidity
* Crops
* Price
* Season

## 🔧 Data Transformation

Snowflake SQL is used to clean and transform the raw data before visualization.

The project includes transformations such as:

* Data cleaning
* Column transformations
* Rainfall grouping
* Data analysis using SQL
* Preparing data for Power BI

## 📈 Power BI Dashboard

The transformed Snowflake data is connected to Power BI to create an interactive analytical report.

The dashboard provides analysis of agricultural data, including rainfall and other factors affecting crop production.

### Dashboard Preview

Add your Power BI screenshot here:

```text
screenshots/powerbi-dashboard.png
```

You can display it in GitHub using:

```markdown
![Power BI Dashboard](screenshots/powerbi-dashboard.png)
```

## 🎯 Key Learning Outcomes

Through this project, I gained practical experience with:

* Amazon S3 data storage
* AWS IAM roles and permissions
* AWS trust policies
* Snowflake Storage Integrations
* Snowflake external stages
* Loading data from S3 into Snowflake
* Snowflake SQL
* Data transformation
* Power BI data connectivity
* Power BI dashboard development
* End-to-end cloud data analytics workflows

## 🚀 End-to-End Workflow

1. Create an S3 bucket.
2. Upload the raw dataset to S3.
3. Create an AWS IAM role.
4. Configure the IAM trust relationship.
5. Create a Snowflake Storage Integration.
6. Connect Snowflake to the S3 bucket.
7. Create an external stage.
8. Load the data into Snowflake.
9. Transform and analyze the data using SQL.
10. Connect Snowflake to Power BI.
11. Build the Power BI dashboard.
12. Publish the report to Power BI Service.

## 🔐 Security

This repository intentionally does **not** contain:

* AWS Access Keys
* AWS Secret Access Keys
* Snowflake passwords
* API keys
* Private keys
* Other authentication credentials

Account IDs, role names, bucket names, and other environment-specific information should be replaced with placeholders if this repository is public.

## 👨‍💻 Author

**Maaz**

Data Analytics Project

**Tools**

AWS S3 · AWS IAM · Snowflake · SQL · Power BI
`AWS S3` · `AWS IAM` · `Snowflake` · `SQL` · `Power BI`

