FROM nginx:latest

# Clear default website
RUN rm -r /usr/share/nginx/html/*

# Copies your code file from your action repository to the filesystem path `/` of the container
ADD code/ /usr/share/nginx/html/

# Download the latest website
WORKDIR /usr/share/nginx/html/

# Add health check to the container
HEALTHCHECK --interval=60s --timeout=10s CMD curl --fail http://localhost:80 || exit 1
