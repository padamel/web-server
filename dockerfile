FROM nginx:latest

LABEL maintainer alpine image-developer

# Verify if python3 is installed 
#
Run which python || echo "python not found" 
  
#  install python3, and py3-pip
#
RUN apt-get update && apt-get install -y \ 
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* 

# Verify python installation

RUN python3 -V

# Set an environment variable for python3 and verify environment variable

ENV PYTHONPATH="/usr/bin/python3.*"

RUN echo "PYTHONPATH is $PYTHONPATH"

# Verify if Nginx is installed

RUN which nginx || echo "return non-zero code is 1, proceed to installation ..."

# Install Nginx and verify Nginx installation

RUN apt-get install -y nginx && \
    nginx -v 

ENTRYPOINT ["nginx status"] 
ENTRYPOINT ["nginx start"] 
#Create a working directory in the container 

WORKDIR /app 

# Copy a file to the default Nginx location

COPY welcome.py /var/www/localhost/htdocs

COPY index.html /var/www/app

# Expose container to a port

EXPOSE 80 

#start nginx

CMD ["/bin/sh"] 
 
