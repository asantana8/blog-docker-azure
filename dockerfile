# Use the official Nginx image as the base image
FROM nginx:latest

# Copy custom configuration file, if needed
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy static website files, if needed
COPY blog/html /usr/share/nginx/html

# Expose port 80
EXPOSE 80