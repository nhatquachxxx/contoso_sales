WITH dim_geography_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_geography`
)

, dim_geography_convert_type AS (
  SELECT
    CAST(geography_key AS INTEGER) AS geography_key
    , UPPER(continent_name) AS continent_name
    , UPPER(city_name) AS city_name
    , UPPER(state_province_name) AS state_province_name
    , UPPER(region_country_name) AS region_country_name
  FROM dim_geography_source
)

SELECT * FROM dim_geography_convert_type