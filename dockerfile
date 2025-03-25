FROM alpine:3.21

LABEL maintainer novist-image-developer

# Verify if python3 is installed 

RUN which python || echo "python not found"  

# Update the container, and install python3, py3-pi and remove packages that are not neccessaries

RUN apk update && apk add --no-cache python3 \ 
    py3-pip \
    && rm -rf /var/lib/apt/lists/* 

# Verify python installation

RUN python3 -V 

# Verify python location

RUN find / -name python3

# Verify if Nginx is installed

RUN nginx -v || echo "return non-zero code is 1, proceed to installation ..."

# Update container environment and install Nginx and verify Nginx installation

RUN apk update && \
    apk add nginx

# Verify if Flask is intalled

RUN flask --version || echo "Flask module not found, proceed to installation..."

# Install Flask

RUN apk add py3-flask

# Install uwsgi program required to run our python app and update alpine 

RUN apk add --no-cache uwsgi && \
    apk update   

# Expose container for web requests to port 80

EXPOSE 80 

# Start nginx service

CMD ["nginx", "-g", "daemon off;"]

