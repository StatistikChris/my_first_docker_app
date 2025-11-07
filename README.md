# My First Docker App with R

This project demonstrates how to create a Docker image that runs an R script.

## What it does

The R script (`script.R`) will:
- Install the `data.table` package
- Load the package
- Print "Hello world!"
- Display the version of data.table

## Files

- `script.R` - The R script that will be executed
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
```bash
docker run my-r-app
```

## Expected output

When you run the container, you should see output similar to:
```
Installing package into '/usr/local/lib/R/site-library'...
[1] "Hello world!"
data.table version: 1.14.8
```

## Notes

- The build process may take a few minutes the first time as it downloads the R base image and installs the data.table package
- Subsequent builds will be faster due to Docker's layer caching