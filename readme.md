# Coding exercise

## Overview

### Hourly weather forecast

**Sample Data**

The table is sample of terminal forecast data, weather prediction for a specific airport.

| stationId | issueTime | forecastValidFrom | forecastValidTo | windDirection | windSpeed | cloudCoverage | type |
| - | - | - | - | - | - | - | - |
| CYVR | 2022-03-30T20:40:00Z | 2022-03-30T21:00:00Z | 2022-03-31T09:00:00Z | 300 | 4.1 | [{"cover":20,"baseHeight":600,"type":"NC"},{"cover":75,"baseHeight":1200,"type":"NC"}] | INITIAL |
| CYVR | 2022-03-30T20:40:00Z | 2022-03-30T21:00:00Z | 2022-03-31T05:00:00Z | 300 | 4.1 | [{"cover":45,"baseHeight":600,"type":"NC"},{"cover":90,"baseHeight":1800,"type":"NC"}] | TEMPO |
| CYVR | 2022-03-30T20:40:00Z | 2022-03-31T09:00:00Z | 2022-03-31T18:00:00Z | 290 | 5.1 | [{"cover":45,"baseHeight":450,"type":"NC"},{"cover":100,"baseHeight":900,"type":"NC"}] | FM |
| CYVR |2022-03-30T20:40:00Z | 2022-03-31T18:00:00Z | 2022-04-01T00:00:00Z | 270 | 5.1 | [{"cover":20,"baseHeight":450,"type":"NC"},{"cover":85,"baseHeight":1500,"type":"NC"}] | FM |
| CYVR | 2022-03-30T23:40:00Z | 2022-03-31T00:00:00Z | 2022-03-31T09:00:00Z | 270 | 4.1 | [{"cover":20,"baseHeight":750,"type":"NC"},{"cover":90,"baseHeight":1600,"type":"NC"}] | INITIAL|

**Column Explained**

* **stationId**: This column represents the airport identifier, with "CYVR" being the code for Vancouver International
Airport.
* **IssueTime**: This is the timestamp indicating when the forecast was issued
* **forecastValidFrom** and **forecastValidTo**: the time range during which the forecast is valid
>Example: The forecast was issued at 20:40 UTC on March 30th, 2022, and is valid from 21:00 UTC on March 30th,
2022, until 09:00 UTC on March 31st, 2022.
* **windDirection**: The wind direction in degrees
* **windSpeed**: This column indicates the speed of the wind
* **cloudCoverage**: This is a JSON-like structure detailing the cloud cover.
>[{ "cover": 20, "baseHeight": 600, "type": "NC" }, { "cover": 75, "baseHeight": 1200, "type": "NC" }]
* **cover**: The percentage of the sky covered by clouds.
* **baseHeight**: The height at which the cloud base is located, measured in feet.
* **type**: The type of cloud coverage, such as "NC" (No Clouds).

## Coding task

Generate an hourly weather summary for the given forecast period. For each hour within the forecast period, calculate and display the following:
* Average Wind Speed: Calculate the average wind speed for each hour.
* Most Common Wind Direction: Determine the most frequent wind direction for each hour.
* Cloud Coverage Summary: For each hour, provide a summary of cloud coverage, including the maximum cloud cover
percentage and the average base height of clouds.

**Expected output**

| Hour | Average wind Speed (knots) | Most common wind direction(degree) | Maximum cloud coverage (%) | Average cloud base height (feet) |
| - | - | - | - | - |
| 2022-03-30 21:00:00 | 4.1 | 300 | 75 | 900 |

## Prerequisites

Ensure you have the following software installed on your laptop:

* git
* Python
* Docker
* DBeaver
* Visual Studio Code (dark theme and extensions: Python, Jupyter, Rainbow CSV)

## Coding solution

1. Clone the repo and access it using VS Code.
1. Generate data using `generate_data.py` script. You can choose the number of rows in the `num_rows` parameter. 
1. Put your JSON file with generated data into the folder `source-data`.
1. Running docker container with PostgreSQL using command
    ```
    docker-compose up --build
    ```
1. If you need to remove docker container you can run command
    ```
    docker-compose down
    ```
1. Connect to the Database using DBeaver or other similar tool. Credentials will be:
    * Host: localhost
    * Database name: airport
    * User: postgres
    * Password: postgres
    * Port: 5433
1. You will see a table `weather_forecast`. 
1. You need to run SQL query from the file `hourly_weather_summary` to get hourly weather summary for the given forecast period.
