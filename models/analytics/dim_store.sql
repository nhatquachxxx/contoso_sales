WITH dim_store_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_store_full`
)

, dim_store_convert_type AS (
  SELECT
    CAST(store_key AS INTEGER) AS store_key
    , CAST(geography_key AS INTEGER) AS geography_key
    , CAST(store_manager AS INTEGER) AS store_manager
    , UPPER(store_type) AS store_type
    , UPPER(store_name) AS store_name
    , store_description
    , UPPER(status) AS store_status
    , CAST(RTRIM(open_date, ' 0:00') AS DATE FORMAT 'MM/DD/YYYY') AS open_date
    , CAST(RTRIM(close_date, ' 0:00') AS DATE FORMAT 'MM/DD/YYYY') AS close_date
    , CAST(entity_key AS INTEGER) AS entity_key
    , zip_code
    , zip_code_extension
    , store_phone
    , store_fax
    , address_line1
    , address_line2
    , close_reason
    , CAST(employee_count AS INTEGER) AS employee_count
    , CAST(selling_area_size AS INTEGER) AS selling_area_size
    , CAST(last_remodel_date AS DATETIME FORMAT 'MM/DD/YYYY HH24:MI') AS last_remodel_date
    , geo_location
    , geometry
    , CAST(etl_load_id AS INTEGER) AS etl_load_id
    , CAST(RTRIM(load_date, ' 0:00') AS DATE FORMAT 'MM/DD/YYYY') AS load_date
    , CAST(RTRIM(update_date, ' 0:00') AS DATE FORMAT 'MM/DD/YYYY') AS update_date
  FROM dim_store_source
)

, dim_store_enhance_geo AS (
  SELECT
    store.store_key
    , store.store_manager
    , store.store_type
    , store.store_name
    , store.store_description
    , store.store_status
    , store.open_date
    , store.close_date
    , store.entity_key
    , store.zip_code
    , store.zip_code_extension
    , store.store_phone
    , store.store_fax
    , store.address_line1
    , store.address_line2
    , store.close_reason
    , store.employee_count
    , store.selling_area_size
    , store.last_remodel_date
    , store.geo_location
    , store.geometry
    , store.etl_load_id
    , store.load_date
    , store.update_date
    , store.geography_key
    , geo.continent_name AS store_continent
    , geo.city_name AS store_city
    , geo.state_province_name AS store_state_province
    , geo.region_country_name AS store_region_country
  FROM dim_store_convert_type AS store
  LEFT JOIN {{ ref ('dim_geography') }} AS geo
    ON store.geography_key = geo.geography_key
)
SELECT * FROM dim_store_enhance_geo