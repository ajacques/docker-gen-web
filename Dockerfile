FROM jwilder/docker-gen

RUN mkdir /tmp/nginx_cache
COPY nginx.tmpl /etc/templates/nginx.tmpl
