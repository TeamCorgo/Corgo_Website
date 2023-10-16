# Use an official Node.js runtime as a parent image
FROM node:latest AS builder

# Copy the build files into the project
COPY . /app

# Set the working directory in the container
WORKDIR /app/Lens

# Install project dependencies using npm
RUN npm install

# Build the project
RUN npm run build

# Create a new stage for the nginx image
FROM nginx:latest

# Copy the built files from the previous stage into the nginx HTML folder
COPY --from=builder /app/Lens/dist /usr/share/nginx/html/Lens

# Copy the built files from the previous stage into the nginx HTML folder
COPY ./content /usr/share/nginx/html

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]

# Add a health check that checks if the web server is responsive
HEALTHCHECK --interval=60s --timeout=60s --retries=3 \
    CMD curl -f http://localhost/ || exit 1