
# Use the official Nginx image
FROM nginx:alpine

# Copy our website into the Nginx web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
