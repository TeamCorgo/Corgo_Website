# Create a new stage for the nginx image
FROM nginx:latest

# Copy the built files from the previous stage into the nginx HTML folder
COPY content /usr/share/nginx/html/

# Copy the custom nginx.conf file to the appropriate location within the container
COPY config /etc/nginx/nginx.conf

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]

# Add a health check that checks if the web server is responsive
HEALTHCHECK --interval=60s --timeout=10s --retries=3 \
    CMD curl -f http://localhost/ || exit 1