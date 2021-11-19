FROM nginx:latest

# Port Map
EXPOSE 84:80

#Install git
RUN apt-get update      
RUN apt-get install -y git

# Clear default website
RUN rm -r /usr/share/nginx/html/*

# Download the latest website
WORKDIR "/usr/share/nginx/html/"
RUN git clone https://github.com/TeamCorgo/Website.git .

HEALTHCHECK --interval=60s --timeout=10s CMD curl --fail http://localhost:80 || exit 1
