# Use rocker/r-ver which has better package management and pre-compiled packages
FROM rocker/r-ver:4.3.2

# Set the working directory in the container
WORKDIR /app

# Install required packages including plumber for web API
RUN install2.r --error \
    data.table \
    plumber \
    jsonlite \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Copy all files to the container
COPY . .

# Make the start script executable
RUN chmod +x start_server.R

# Expose port 8080 for Cloud Run
EXPOSE 8080

# Run the web server
CMD ["Rscript", "start_server.R"]