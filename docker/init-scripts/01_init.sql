-- Create schema "weather"
CREATE SCHEMA IF NOT EXISTS weather;

-- Create table "weather_forecast_raw" for loading JSON data
CREATE TABLE IF NOT EXISTS weather.weather_forecast_raw (
    raw_data JSONB
);

-- Create final table "weather_forecast"
CREATE TABLE IF NOT EXISTS weather.weather_forecast (
    _row_id SERIAL PRIMARY KEY,
    _etl_timestamp TIMESTAMPTZ DEFAULT NOW(),
    stationId VARCHAR(10),
    issueTime TIMESTAMPTZ,
    forecastValidFrom TIMESTAMPTZ,
    forecastValidTo TIMESTAMPTZ,
    windDirection INT,
    windSpeed FLOAT,
    cloudCoverage JSONB,
    type VARCHAR(10)
);
