# Create a new stage for the nginx image
FROM nginx:latest

# Copy the built files from the previous stage into the nginx HTML folder
COPY ./content /usr/share/nginx/html

# Copy nginx config files (Override)
COPY ./config /etc/nginx

# Create a directory for logs
RUN mkdir /etc/nginx/logs

# Define a named volume for logs
VOLUME /etc/nginx/logs

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]

# Add a health check that checks if the web server is responsive
HEALTHCHECK --interval=60s --timeout=60s --retries=3 \
    CMD curl -f http://localhost/health || exit 1