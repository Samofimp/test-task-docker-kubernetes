FROM alpine:3.15

# install nginx
RUN apk add nginx

COPY ./src/default.conf /etc/nginx/http.d/default.conf
COPY ./src/nginx.conf /etc/nginx/nginx.conf
COPY ./src/index.html /var/lib/nginx/html/index.html

# add permissions for nginx user
RUN chown -R nginx:nginx /var/lib/nginx && chmod -R 755 /var/lib/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/http.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

EXPOSE 80

# switch to nginx user to run nginx as non-root
USER nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
