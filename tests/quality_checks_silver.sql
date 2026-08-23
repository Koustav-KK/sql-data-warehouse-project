
/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
     - Null or duplicate primary keys.
     - unwanted spaces in string fields.
     - Data standardization and consistency.
     - Invalid data ranges and orders.
     - Data consistency between related fields.

Usage Notes:
     - Run these checks after data loading Silver Layer.
     - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- Check For Nulls pr Duplicates in Primary Key
-- Expectation: No Result
SELECT 
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted Spaces
-- Expectations: No Results
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Check for unwanted Spaces
-- Expectations: No Results
SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- Data Stadardization & Concistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

-- Data Stadardization & Concistency
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info


-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- Check for Invalid Date Orders
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

-- Identify Out-Of_Range Dates
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()


-- Data Standardization & Consistency
SELECT
gen
FROM silver.erp_cust_az12

-- Data Standardization & Consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry

SELECT * FROM silver.erp_px_cat_g1v2

SELECT * FROM silver.crm_sales_details
