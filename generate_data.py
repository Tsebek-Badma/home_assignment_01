import json
import random
from datetime import datetime, timedelta

# Function to generate a random datetime within a specified range, without seconds
def random_date_without_seconds(start, end):
    random_time = start + timedelta(minutes=random.randint(0, int((end - start).total_seconds() / 60)))
    return random_time.replace(second=0, microsecond=0)

# Function to generate a random datetime with only hours (minutes and seconds set to 00)
def random_hour(start, end):
    random_time = start + timedelta(hours=random.randint(0, int((end - start).total_seconds() / 3600)))
    return random_time.replace(minute=0, second=0, microsecond=0)

# Function to generate random cloud coverage data
def generate_cloud_coverage():
    num_layers = random.randint(1, 3)  # Random number of cloud layers (1 to 3)
    cloud_layers = []
    for _ in range(num_layers):
        layer = {
            "cover": random.randint(0, 100),  # Random cloud cover percentage
            "baseHeight": random.randint(300, 3000),  # Random base height in feet
            "type": random.choice(["NC", "SC", "FC"])  # Random cloud type
        }
        cloud_layers.append(layer)
    return cloud_layers

# Parameters for data generation
num_rows = 10000
start_date = datetime(2022, 3, 30, 20, 40)  # Start date for issueTime
end_date = datetime(2022, 6, 1, 0, 0)  # End date for forecastValidTo

# Generate data
data = []
for _ in range(num_rows):
    issue_time = random_date_without_seconds(start_date, end_date)
    forecast_valid_from = random_hour(start_date, end_date)
    forecast_valid_to = random_hour(forecast_valid_from, end_date)

    record = {
        "stationId": "CYVR",
        "issueTime": issue_time.isoformat() + "Z",
        "forecastValidFrom": forecast_valid_from.isoformat() + "Z",
        "forecastValidTo": forecast_valid_to.isoformat() + "Z",
        "windDirection": random.choice([270, 290, 300, 310]),
        "windSpeed": round(random.uniform(0.0, 10.0), 1),
        "cloudCoverage": generate_cloud_coverage(),
        "type": random.choice(["INITIAL", "TEMPO", "FM"])
    }
    data.append(record)

# Save to JSON
with open("weather_forecast_data.json", "w") as f:
    json.dump(data, f, indent=4)

print(f"{num_rows} rows of dummy data have been generated and saved to 'weather_forecast_data.json'.")