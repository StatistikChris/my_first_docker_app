#!/usr/bin/env Rscript

# Get the port from environment variable (Cloud Run sets PORT=8080)
port <- as.numeric(Sys.getenv("PORT", "8080"))
host <- "0.0.0.0"

cat("Starting R server on", host, ":", port, "\n")

# Create and start the plumber API
library(plumber)
pr <- pr("server.R")
pr$run(host = host, port = port)