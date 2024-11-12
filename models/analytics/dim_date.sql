WITH dim_date_call_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_date`
)

, dim_date_convert_type AS (
  SELECT
    CAST(date AS DATE FORMAT 'MM/DD/YYYY') AS date
    , CAST(calendar_year AS INTEGER) AS calendar_year
    , calendar_half_year
    , calendar_quarter
    , calendar_month
    , LEFT(calendar_week, 5) || CAST(CAST(SUBSTR(calendar_week,6) AS INTEGER) AS STRING FORMAT '00') AS calendar_week
    , calendar_dayof_week AS calendar_day_of_week
    , CAST(fiscal_year AS INTEGER) AS fiscal_year
    , fiscal_half_year
    , fiscal_quarter
    , LEFT(fiscal_month, 6) || CAST(CAST(SUBSTR(fiscal_month,7) AS INTEGER) AS STRING FORMAT '00') AS fiscal_month
    , is_workday
    , europe_season
    , north_america_season
    , asia_season
  FROM dim_date_call_source
)

, dim_date_upper_case AS (
  SELECT
    date
    , calendar_year
    , UPPER(calendar_half_year) AS calendar_half_year
    , UPPER(calendar_quarter) AS calendar_quarter
    , UPPER(calendar_month) AS calendar_month
    , UPPER(calendar_week) AS calendar_week
    , UPPER(calendar_day_of_week) AS calendar_day_of_week
    , fiscal_year
    , UPPER(fiscal_half_year) AS fiscal_half_year
    , UPPER(fiscal_quarter) AS fiscal_quarter
    , UPPER(fiscal_month) AS fiscal_month
    , UPPER(is_workday) AS is_workday
    , UPPER(europe_season) AS europe_season
    , UPPER(north_america_season) AS north_america_season
    , UPPER(asia_season) AS asia_season
  FROM dim_date_convert_type
)

SELECT
  *
FROM dim_date_upper_case