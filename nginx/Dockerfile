FROM nginx:alpine

# Copy the custom NGINX configuration file from your local machine to the image
COPY configs/default.conf /etc/nginx/conf.d/default.conf

WORKDIR usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
