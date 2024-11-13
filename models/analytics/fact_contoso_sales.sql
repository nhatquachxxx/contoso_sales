WITH fact_contoso_sales_combine_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.2007_contoso`

  UNION ALL
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.2008_contoso`

  UNION ALL
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.2009_contoso`
)

, fact_contoso_sales_convert_type AS (
  SELECT
    CAST(sales_key AS INTEGER) AS sales_key
    , CAST(date_key AS INTEGER) AS date_key
    , CAST(channel_key AS INTEGER) AS channel_key
    , CAST(store_key AS INTEGER) AS store_key
    , CAST(product_key AS INTEGER) AS product_key
    , CAST(promotion_key AS INTEGER) AS promotion_key
    , CAST(unit_cost AS NUMERIC) AS unit_cost
    , CAST(unit_price AS NUMERIC) AS unit_price
    , CAST(sales_quantity AS INTEGER) AS sales_quantity
    , CAST(return_quantity AS INTEGER) AS return_quantity
    , CAST(return_amount AS NUMERIC) AS return_amount
    , CAST(discount_quantity AS INTEGER) AS discount_quantity
    , CAST(discount_amount AS NUMERIC) AS discount_amount
    , CAST(total_cost AS NUMERIC) AS total_cost
    , CAST(sales_amount AS NUMERIC) AS sales_amount
    , CAST(geography_key AS INTEGER) AS geography_key
    , CAST(date AS DATE FORMAT 'MM/DD/YYYY' ) AS date
  FROM fact_contoso_sales_combine_source
)

SELECT * FROM fact_contoso_sales_convert_type