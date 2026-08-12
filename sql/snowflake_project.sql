-- ============================================================
-- AWS S3 → Snowflake → Power BI Project
-- ============================================================

-- ============================================================
-- 1. CREATE SNOWFLAKE STORAGE INTEGRATION
-- ============================================================

CREATE STORAGE INTEGRATION PBI_Integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN =
    'arn:aws:iam::<AWS_ACCOUNT_ID>:role/<AWS_ROLE_NAME>'
STORAGE_ALLOWED_LOCATIONS =
    ('s3://<S3_BUCKET_NAME>');


-- Check the integration
DESC STORAGE INTEGRATION PBI_Integration;


-- ============================================================
-- 2. CREATE DATABASE AND SCHEMA
-- ============================================================

CREATE DATABASE PowerBI;

CREATE SCHEMA POWERBI.PBI_DATASET;


-- ============================================================
-- 3. CREATE TABLE
-- ============================================================

CREATE TABLE POWERBI.PBI_DATASET.PBI_Dataset (
    Year INT,
    Location STRING,
    Area INT,
    Rainfall FLOAT,
    Temperature FLOAT,
    Soil_type STRING,
    Irrigation STRING,
    Yeilds INT,
    Humidity FLOAT,
    Crops STRING,
    Price INT,
    Season STRING
);


-- Check the table
SELECT *
FROM POWERBI.PBI_DATASET.PBI_Dataset;


-- ============================================================
-- 4. CREATE EXTERNAL STAGE
-- ============================================================

CREATE STAGE POWERBI.PBI_DATASET.PBI_STAGE
URL = 's3://<S3_BUCKET_NAME>'
STORAGE_INTEGRATION = PBI_Integration;


-- Check the stage
DESC STAGE POWERBI.PBI_DATASET.PBI_STAGE;


-- ============================================================
-- 5. LOAD DATA FROM S3 INTO SNOWFLAKE
-- ============================================================

COPY INTO POWERBI.PBI_DATASET.PBI_Dataset
FROM @POWERBI.PBI_DATASET.PBI_STAGE
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
)
ON_ERROR = 'CONTINUE';


-- Check files in the stage
LIST @POWERBI.PBI_DATASET.PBI_STAGE;


-- ============================================================
-- 6. BASIC DATA ANALYSIS
-- ============================================================

SELECT
    Year,
    COUNT(*)
FROM POWERBI.PBI_DATASET.PBI_Dataset
GROUP BY Year
ORDER BY Year;


-- ============================================================
-- 7. CREATE AGRICULTURE TABLE
-- ============================================================

CREATE TABLE agriculture AS
SELECT *
FROM POWERBI.PBI_DATASET.PBI_Dataset;


SELECT *
FROM agriculture;


-- ============================================================
-- 8. DATA TRANSFORMATION
-- ============================================================

UPDATE agriculture
SET Rainfall = 1.1 * Rainfall;

UPDATE agriculture
SET Area = 0.9 * Area;


-- ============================================================
-- 9. CREATE YEAR GROUP
-- ============================================================

-- Y1 = 2004–2009
-- Y2 = 2010–2015
-- Y3 = 2016–2019

ALTER TABLE agriculture
ADD Year_Group STRING;


UPDATE agriculture
SET Year_Group = 'Y1'
WHERE Year >= 2004
  AND Year <= 2009;


UPDATE agriculture
SET Year_Group = 'Y2'
WHERE Year >= 2010
  AND Year <= 2015;


UPDATE agriculture
SET Year_Group = 'Y3'
WHERE Year >= 2016
  AND Year <= 2019;


-- Check transformation
SELECT *
FROM agriculture;


-- ============================================================
-- 10. CREATE RAINFALL GROUP
-- ============================================================

-- Low:    255–1199
-- Medium: 1200–2799
-- High:   2800–4103

ALTER TABLE agriculture
ADD Rainfall_Groups STRING;


UPDATE agriculture
SET Rainfall_Groups = 'Low'
WHERE Rainfall >= 255
  AND Rainfall < 1200;


UPDATE agriculture
SET Rainfall_Groups = 'Medium'
WHERE Rainfall >= 1200
  AND Rainfall < 2800;


UPDATE agriculture
SET Rainfall_Groups = 'High'
WHERE Rainfall >= 2800
  AND Rainfall < 4103;


-- Final dataset
SELECT *
FROM agriculture;
