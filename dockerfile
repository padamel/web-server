FROM nginx:latest

LABEL maintainer novist-image-developer

# Verify if python3 is installed 

RUN which python || echo "python not found" 
  
# Update the container, and install python3 and py3-pip

RUN apt-get update && apt-get install -y \ 
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* 

# Verify python installation

RUN python3 -V > /tmp/python_version

# Read the Python version from the file and set it as an ENV variable

RUN export PYTHON_VERSION=$(cat /tmp/python_version) && \
    echo "PYTHON_VERSION=$PYTHON_VERSION"

# Set PYTHONPATH dynamically based on python version 

RUN export PYTHONPATH="/usr/bin/python3" && \
    echo "PYTHONPATH=$PYTHONPATH" >> /etc/environment

# Verify if Nginx is installed

RUN nginx -v || echo "return non-zero code is 1, proceed to installation ..."

# Update container environment and install Nginx and verify Nginx installation

RUN apt-get update && \
    apt-get install -y nginx

#ENTRYPOINT ["nginx status"] 
#ENTRYPOINT ["nginx", "-g", "daemon off;"]  
#Create a working directory in the container 

WORKDIR /app 

# Copy a file to the default Nginx location

COPY welcome.py /app

#/usr/share/nginx/html

#COPY index.html /var/www/app

# Modify Nginx configuration to serve Python scripts

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose container for web requests to port 80

EXPOSE 80 

CMD ["RUN"]

