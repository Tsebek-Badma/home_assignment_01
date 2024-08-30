-- Process JSON data from the raw table and insert into the final table
INSERT INTO weather.weather_forecast (stationId, issueTime, forecastValidFrom, forecastValidTo, windDirection, windSpeed, cloudCoverage, type)
SELECT 
    raw_data->>'stationId' AS stationId,
    (raw_data->>'issueTime')::TIMESTAMPTZ AS issueTime,
    (raw_data->>'forecastValidFrom')::TIMESTAMPTZ AS forecastValidFrom,
    (raw_data->>'forecastValidTo')::TIMESTAMPTZ AS forecastValidTo,
    (raw_data->>'windDirection')::INT AS windDirection,
    (raw_data->>'windSpeed')::FLOAT AS windSpeed,
    raw_data->'cloudCoverage' AS cloudCoverage,
    raw_data->>'type' AS type
FROM weather.weather_forecast_raw;

-- Optionally, remove the raw data table
-- DROP TABLE IF EXISTS weather.weather_forecast_raw;
