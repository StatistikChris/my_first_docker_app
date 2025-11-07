# Use the official R base image
FROM r-base:latest

# Set the working directory in the container
WORKDIR /app

# Copy the R script to the container
COPY script.R .

# Install any additional system dependencies if needed
# (data.table has some dependencies that are usually available in r-base)
RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# Run the R script when the container starts
CMD ["Rscript", "script.R"]