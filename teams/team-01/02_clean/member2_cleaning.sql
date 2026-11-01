-- 1. Remove duplicate records
CREATE TABLE IF NOT EXISTS clean_applicants AS
SELECT DISTINCT *
FROM stg_applicants;

CREATE TABLE IF NOT EXISTS clean_admission_status AS
SELECT DISTINCT *
FROM stg_admission_status;


-- 2. Standardize gender
CREATE TABLE IF NOT EXISTS clean_applicants_v2 AS
SELECT *,
    CASE
        WHEN LOWER(TRIM(gender)) IN ('f', 'female')
            THEN 'Female'
        WHEN LOWER(TRIM(gender)) IN ('m', 'male')
            THEN 'Male'
        ELSE TRIM(gender)
    END AS standardized_gender
FROM clean_applicants;


-- 3. Standardize city names
CREATE TABLE IF NOT EXISTS clean_applicants_v3 AS
SELECT *,
    CASE
        WHEN UPPER(TRIM(home_city)) IN ('FSD', 'FAISALABAD')
            THEN 'Faisalabad'
        WHEN UPPER(TRIM(home_city)) IN ('HYD', 'HYDERABAD')
            THEN 'Hyderabad'
        WHEN UPPER(TRIM(home_city)) IN ('ISB', 'ISLAMABAD')
            THEN 'Islamabad'
        WHEN UPPER(TRIM(home_city)) IN ('KHI', 'KARACHI')
            THEN 'Karachi'
        WHEN UPPER(TRIM(home_city)) IN ('LHR', 'LAHORE')
            THEN 'Lahore'
        WHEN UPPER(TRIM(home_city)) IN ('MUX', 'MULTAN')
            THEN 'Multan'
        WHEN UPPER(TRIM(home_city)) IN ('PEW', 'PESHAWAR')
            THEN 'Peshawar'
        WHEN UPPER(TRIM(home_city)) IN ('PINDI', 'RAWALPINDI')
            THEN 'Rawalpindi'
        WHEN UPPER(TRIM(home_city)) IN ('SKR', 'SUKKUR')
            THEN 'Sukkur'
        WHEN UPPER(TRIM(home_city)) = 'QUETTA'
            THEN 'Quetta'
        ELSE TRIM(home_city)
    END AS standardized_city
FROM clean_applicants_v2;



SELECT COUNT(*) AS total_rows
FROM clean_applicants_v4;


-- MEMBER 2: DATA CLEANING
-- Database: hec_data_warehouse.db

-- 1. Remove duplicate rows from staging data
CREATE TABLE IF NOT EXISTS clean_applicants AS
SELECT DISTINCT *
FROM stg_applicants;

CREATE TABLE IF NOT EXISTS clean_admission_status AS
SELECT DISTINCT *
FROM stg_admission_status;


-- 2. Verify duplicate removal
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT applicant_id) AS unique_applicants
FROM clean_applicants;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT applicant_id) AS unique_applicants
FROM clean_admission_status;


-- 3. Verify gender standardization
SELECT gender, COUNT(*) AS total
FROM clean_applicants_v3
GROUP BY gender;


-- 4. Verify city standardization
SELECT home_city, COUNT(*) AS total
FROM clean_applicants_v3
GROUP BY home_city
ORDER BY home_city;


-- 5. Verify DOB standardization
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN standardized_dob IS NULL
          OR TRIM(standardized_dob) = ''
        THEN 1 ELSE 0
    END) AS missing_dob,
    SUM(CASE
        WHEN date(standardized_dob) IS NULL
        THEN 1 ELSE 0
    END) AS invalid_dob
FROM clean_applicants_v4;


-- 6. Final applicant validation
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT applicant_id) AS unique_applicants,
    SUM(CASE
        WHEN applicant_id IS NULL THEN 1
        ELSE 0
    END) AS missing_applicant_id
FROM clean_applicants_v4;