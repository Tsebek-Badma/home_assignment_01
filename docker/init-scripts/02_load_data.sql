-- Read the JSON file and insert its contents into the raw data table
INSERT INTO weather.weather_forecast_raw (raw_data)
SELECT json_array_elements(pg_read_file('/docker-entrypoint-initdb.d/data/weather_forecast_data.json')::json);
