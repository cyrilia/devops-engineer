# Use a lightweight web server as a base image
FROM nginx:alpine

# Copy your static HTML pages into the default web server directory
COPY index.html /usr/share/nginx/html/
COPY about.html /usr/share/nginx/html/

# Expose port 80 for web traffic
EXPOSE 80