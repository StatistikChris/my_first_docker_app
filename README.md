# My First Docker App with R

This project demonstrates how to create a Docker image that runs an R script.

## What it does

The R script (`script.R`) will:
- Install the `data.table` package
- Load the package
- Print "Hello world!"
- Display the version of data.table
- Read a CSV file (`sample_data.csv`) into a data.table object
- Accept command-line arguments to specify which columns to display
- Print the first few rows of the selected columns using `head()`

## Files

- `script.R` - The R script that will be executed
- `sample_data.csv` - Sample CSV file with employee data
- `Dockerfile` - Instructions for building the Docker image
- `README.md` - This file

## How to build and run

### Prerequisites
- Docker installed on your system

### Build the Docker image
```bash
docker build -t my-r-app .
```

### Run the Docker container

**Show all columns (default behavior):**
```bash
docker run my-r-app
```

**Show specific columns:**
```bash
docker run my-r-app "name,age"
```

**Show single column:**
```bash
docker run my-r-app "salary"
```

**Show multiple columns (comma-separated):**
```bash
docker run my-r-app "name,city,salary"
```

## Expected output

## Expected output

**When showing all columns (no arguments):**
```
Installing package into '/usr/local/lib/R/site-library'...
[1] "Hello world!"
data.table version: 1.14.8

Reading CSV file into data.table...
No column names specified. Showing all columns:
Available columns: name, age, city, salary

First few rows of the data.table:
     name age        city salary
1:   John  25    New York  50000
2:  Alice  30 Los Angeles  60000
3:    Bob  35     Chicago  55000
4:  Carol  28     Houston  52000
5:  David  32     Phoenix  58000
6:    Eve  29 Philadelphia  53000
```

**When showing specific columns (e.g., "name,salary"):**
```
Installing package into '/usr/local/lib/R/site-library'...
[1] "Hello world!"
data.table version: 1.14.8

Reading CSV file into data.table...
Displaying columns: name, salary

First few rows of the selected columns:
     name salary
1:   John  50000
2:  Alice  60000
3:    Bob  55000
4:  Carol  52000
5:  David  58000
6:    Eve  53000
```

## Notes

- The build process may take a few minutes the first time as it downloads the R base image and installs the data.table package
- Subsequent builds will be faster due to Docker's layer caching
- Column names are case-sensitive and should match exactly as they appear in the CSV file
- Multiple columns should be separated by commas (e.g., "name,age,salary")
- If invalid column names are provided, the script will show a warning and display available columns
- Available columns in the sample data: `name`, `age`, `city`, `salary`