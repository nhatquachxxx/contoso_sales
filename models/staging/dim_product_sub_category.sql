WITH dim_sub_category_source AS (
  SELECT
    *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_product_sub_category`
)

, dim_sub_category_convert_type AS (
  SELECT
    CAST(product_sub_category_key AS INTEGER) AS product_sub_category_key
    , UPPER(product_sub_category_name) AS product_sub_category_name
    , CAST(product_category_key AS INTEGER) AS product_category_key
  FROM dim_sub_category_source
)
SELECT * FROM dim_sub_category_convert_type