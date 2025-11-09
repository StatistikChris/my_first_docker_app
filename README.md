# My First Docker App with R

This project demonstrates how to create a Docker image that runs an R script.

## What it does

This Docker container runs an R web API that:
- Loads the `data.table` package (pre-installed in the image)
- Reads a CSV file (`sample_data.csv`) into a data.table object
- Provides a REST API to interact with the data
- Supports filtering columns via query parameters
- Runs as a web server compatible with Cloud Run

## Files

- `server.R` - The R web API using plumber framework
- `start_server.R` - Script to start the web server
- `script.R` - Original R script (kept for reference)
- `sample_data.csv` - Sample CSV file with employee data
- `Dockerfile` - Instructions for building the Docker image
- `README.md` - This file

## How to build and run

### Prerequisites
- Docker installed on your system

### Build the Docker image

**For Linux/AMD64 platforms (cloud environments):**
```bash
docker build --platform linux/amd64 -t my-r-app .
```

**For local development (auto-detect platform):**
```bash
docker build -t my-r-app .
```

### Run the Docker container

**Run locally (will start web server on port 8080):**
```bash
docker run -p 8080:8080 my-r-app
```

**Test the API endpoints:**
```bash
# Health check
curl http://localhost:8080/health

# Get all data
curl http://localhost:8080/data

# Get specific columns
curl "http://localhost:8080/data?columns=name,salary"

# Root endpoint (API info)
curl http://localhost:8080/
```

## Expected output

## API Endpoints

### GET /health
Returns API status and basic information:
```json
{
  "status": "healthy",
  "message": "Hello world!",
  "data_table_version": "1.17.8",
  "available_columns": ["name", "age", "city", "salary"]
}
```

### GET /data
Returns all data:
```json
{
  "message": "Showing all columns",
  "available_columns": ["name", "age", "city", "salary"],
  "data": [
    {"name": "John", "age": 25, "city": "New York", "salary": 50000},
    {"name": "Alice", "age": 30, "city": "Los Angeles", "salary": 60000}
  ]
}
```

### GET /data?columns=name,salary
Returns filtered columns:
```json
{
  "message": "Displaying columns: name, salary",
  "requested_columns": ["name", "salary"],
  "data": [
    {"name": "John", "salary": 50000},
    {"name": "Alice", "salary": 60000}
  ]
}
```

## Notes

- The build process may take a few minutes the first time as it downloads the R base image and installs the data.table package
- Subsequent builds will be faster due to Docker's layer caching
- Column names are case-sensitive and should match exactly as they appear in the CSV file
- Multiple columns should be separated by commas (e.g., "name,age,salary")
- If invalid column names are provided, the script will show a warning and display available columns
- Available columns in the sample data: `name`, `age`, `city`, `salary`