WITH dim_category_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_product_category`
)

, dim_category_convert_type AS (
  SELECT
    CAST(product_category_key AS INTEGER) AS product_category_key
    , UPPER(product_category_name) AS product_category_name
  FROM dim_category_source
)

SELECT * FROM dim_category_convert_type