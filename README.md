# docker-gen-web
Docker-gen templates for web applications

This is a basic Docker container that will automatically configure NGINX for web applications.

## Running
The following config can be used to configure and run this instance:
### Docker Compose
```
nginx:
  ports:
  - 80:80/tcp
  - 443:443/tcp
  labels:
    io.rancher.container.pull_image: always
  image: nginx:1.9.10
  cpu_shares: 256
  volumes:
  - /etc/nginx:/etc/nginx:ro
  - /var/log/nginx:/var/log/nginx
  net: bridge
  mem_limit: 134217728
docker-gen:
  cap_drop:
    - ALL
  labels:
    io.rancher.container.pull_image: always
  tty: true
  command:
    - -watch
    - -only-exposed
    - -notify-sighup
    - nginx
    - /etc/templates/nginx.tmpl
    - /etc/nginx/sites-enabled/docker.conf
  image: docker-gen-web:1
  cpu_shares: 8
  volumes:
    - /var/run/docker.sock:/tmp/docker.sock:ro
    - /etc/nginx:/etc/nginx
  stdin_open: false
  net: none
  mem_limit: 16777216
```

## Configuring
A few different options are available for configuring web app containers

| Key | Required | Default | Example | Description |
| --- | -------- | ------- | ------- | ----------- |
| VIRTUAL_HOST | Yes | | example.com | The domain name to forward to this container |
| VIRTUAL_PORT | No | Exposed port on container | 3000 | Port inside the container to forward to |
| GENERATE_SERVER_BLOCK | No | false | true/false | Whether or not to generate server {} block in NGINX |
| CERT_NAME | No | | example_com | Name of the certificate to use |
| HTTP_MAX_CLIENT_REQUEST_SIZE | No | 1m | 500m | Maximum number of bytes clients can upload. See [NGINX docs](http://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size)
