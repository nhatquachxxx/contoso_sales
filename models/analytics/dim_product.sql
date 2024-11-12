WITH dim_product_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_product`
)

, dim_product_convert_type AS (
  SELECT
    CAST(product_key AS INTEGER) AS product_key
    , UPPER(product_name) AS product_name
    , product_description
    , CAST(product_subcategory_key AS INTEGER) AS product_subcategory_key
    , manufacturer
    , UPPER(brand_name) AS brand_name
    , UPPER(class_name) AS class_name
    , UPPER(color_name) AS color_name
    , size
    , size_range
    , CAST(weight AS NUMERIC) AS weight
    , UPPER(weight_unit_measure_id) AS weight_unit_measure_id
    , CAST(unit_cost AS NUMERIC) AS unit_cost
    , CAST(unit_price AS NUMERIC) AS unit_price
  FROM dim_product_source
)

, dim_product_combine_category AS (
  SELECT
    product.product_key
    , product.product_name
    , product.product_description
    , product.product_subcategory_key
    , product.manufacturer
    , product.brand_name
    , product.class_name
    , product.color_name
    , product.size
    , product.size_range
    , product.weight
    , product.weight_unit_measure_id
    , product.unit_cost
    , product.unit_price
    , sub_cate.product_sub_category_name AS product_sub_category_name
    , sub_cate.product_category_key AS product_category_key
    , cate.product_category_name AS product_category_name
  FROM dim_product_convert_type AS product
  LEFT JOIN {{ ref ('dim_product_sub_category') }} AS sub_cate
    ON product.product_subcategory_key = sub_cate.product_sub_category_key
  LEFT JOIN {{ ref ('dim_product_category') }} AS cate
    ON sub_cate.product_category_key = cate.product_category_key
)
SELECT * FROM dim_product_combine_category