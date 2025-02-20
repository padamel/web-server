FROM alpine:3.21

LABEL maintainer novist-image-developer

# Verify if python3 is installed 

RUN which python || echo "python not found" 

# Set environment variable for uWSGI configuration

ENV APP_ROOT=/usr/share/nginx/html
  
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

# Install Flask and wsgi

RUN apk add py3-flask

# Install uwsgi program required to run our python app

RUN apk add --no-cache uwsgi 
    
WORKDIR /home \
        $APP_ROOT
        

#Copy the python application and the uwsgi file to the defined directory
COPY app1.py /home

COPY config_uwsgi.ini $APP_ROOT  


# Expose container for web requests to port 80

EXPOSE 80 

# Run uwsgi with the configuration in the .ini file

CMD ["RUN","apk", "uwsgi", "--ini", "config_uwsgi.ini"]

