WITH dim_channel_source AS (
  SELECT *
  FROM `looker-team-management-386803.jira_clv_staging.source_dim_channel`
)

, dim_channel_convert_type AS (
  SELECT
    CAST(channel_key AS INTEGER) AS channel_key
    , UPPER(channel_name) AS channel_name
    FROM dim_channel_source
)

SELECT * FROM dim_channel_convert_type