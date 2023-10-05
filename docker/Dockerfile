# Create a new stage for the nginx image
FROM nginx:latest

# Break cacheing to force latest downloads
#DD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache

# Clone your GitHub repository
#RUN git clone https://github.com/TeamCorgo/ZeroZone_Front.git

# Copy the built files from the previous stage into the nginx HTML folder
COPY ../content/ /usr/share/nginx/html/

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]
