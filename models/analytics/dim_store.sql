WITH dim_store_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_store`
)

, dim_store_convert_type AS (
  SELECT
    CAST(store_key AS INTEGER) AS store_key
    , CAST(store_manager AS INTEGER) AS store_manager
    , UPPER(store_name) AS store_name
    , CAST(open_date AS DATE FORMAT 'MM/DD/YYYY') AS open_date
    , CAST(close_date AS DATE FORMAT 'MM/DD/YYYY') AS close_date
    , zip_code
    , store_phone
    , address_line1
    , address_line2
    , CAST(employee_count AS INTEGER) AS employee_count
    , CAST(selling_area_size AS INTEGER) AS selling_area_size
    , UPPER(manager_first_name) AS manager_first_name
    , UPPER(manager_last_name) AS manager_last_name
  FROM dim_store_source
)

SELECT * FROM dim_store_convert_type