# docker-gen-web
Docker-gen templates for web applications

This is a basic Docker container that will automatically configure NGINX for web applications.

## Running
The following config can be used to configure and run this instance:
Docker Compose
```
docker-gen:
  cap_drop:
    - ALL
  labels:
    io.rancher.container.pull_image: always
    io.rancher.scheduler.affinity:host_label: web_host=true
  tty: true
  command:
    - -watch
    - -only-exposed
    - -notify-sighup
    - nginx
    - /etc/templates/nginx.tmpl
    - /etc/nginx/sites-enabled/docker.conf
  image: docker-gen:1
  cpu_shares: 8
  volumes:
    - /var/run/docker.sock:/tmp/docker.sock:ro
    - /etc/nginx:/etc/nginx
  stdin_open: false
  net: none
  mem_limit: 16777216
  ```
