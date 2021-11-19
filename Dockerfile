FROM nginx:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
ADD code/ /usr/share/nginx/html/

# Download the latest website
WORKDIR "/usr/share/nginx/html/

#RUN git clone https://github.com/TeamCorgo/Website.git .

HEALTHCHECK --interval=60s --timeout=10s CMD curl --fail http://localhost:80 || exit 1




# Port Map
#EXPOSE 84:80

#Install git
#RUN apt-get update      
#RUN apt-get install -y git

# Clear default website
# RUN rm -r /usr/share/nginx/html/*

# Copies your code file from your action repository to the filesystem path `/` of the container
#COPY entrypoint.sh /entrypoint.sh

# Download the latest website
#WORKDIR "/usr/share/nginx/html/"
#RUN git clone https://github.com/TeamCorgo/Website.git .

#HEALTHCHECK --interval=60s --timeout=10s CMD curl --fail http://localhost:80 || exit 1
