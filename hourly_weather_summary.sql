WITH expanded_weather_forecast AS (
    SELECT
        stationId,
        issueTime,
        forecastValidFrom,
        forecastValidTo,
        windDirection,
        windSpeed,
        (cloudCoverage_elem ->> 'cover')::INTEGER AS cloudCoverage_cover,
        (cloudCoverage_elem ->> 'baseHeight')::INTEGER AS cloudCoverage_baseHeight,
        cloudCoverage_elem ->> 'type' AS cloudCoverage_type,
        type
    FROM
        weather_forecast,
        jsonb_array_elements(cloudCoverage) AS cloudCoverage_elem
),
hourly_data AS (
    SELECT
		generate_series(
            date_trunc('hour', forecastValidFrom),
            date_trunc('hour', forecastValidTo),
            interval '1 hour'
        ) AS forecast_hour,
        forecastValidFrom,
        forecastValidTo,
        windSpeed,
        windDirection,
        cloudCoverage_cover,
        cloudCoverage_baseHeight
    FROM
        expanded_weather_forecast
),
hourly_summary AS (
    SELECT
        forecast_hour,
        AVG(windSpeed) AS avg_wind_speed,
        MODE() WITHIN GROUP (ORDER BY windDirection) AS most_common_wind_direction,
        MAX(cloudCoverage_cover) AS max_cloud_coverage,
        AVG(cloudCoverage_baseHeight) AS avg_cloud_base_height
    FROM
        hourly_data
    where forecastValidTo > forecast_hour
    GROUP BY
        forecast_hour
)
select
	forecast_hour,
    ROUND(avg_wind_speed, 2) AS avg_wind_speed,
    most_common_wind_direction,
    max_cloud_coverage,
    ROUND(avg_cloud_base_height, 2) AS avg_cloud_base_height
from hourly_summary
order by forecast_hour
;
