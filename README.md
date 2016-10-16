# caddy-proxy

Automated [caddy](https://github.com/mholt/caddy) proxy for Docker containers using docker-gen.
Launching and stopping containers will automatically updated the proxy.

### Versioning
Since this Docker image is intended to serve as an enhanced version of caddy, the versioning of this project will be tied directly to the corresponding caddy version.

### Prerequisites
- Docker socket must be mounted (read only is sufficient) so docker-gen works.

### Usage

#### Proxy

All containers started with an env var `VIRTUAL_HOST` will be automatically proxied.:

```sh
$ docker run -e VIRTUAL_HOST=subdomain.example.com  ...
```

#### Basic Auth

To protect any container with HTTP Basic Authentication add a `BASIC_AUTH` env var path (i.e. `/`), username, and password:

```sh
$ docker run -e VIRTUAL_HOST=subdomain.example.com -e BASIC_AUTH="/ myname mysecrect" ...
```

#### Caddy options

You can pass in caddy run arguments inside the env var `CADDY_OPTIONS`.

```sh
$ docker run -e VIRTUAL_HOST=subdomain.example.com -e CADDY_OPTIONS="--email webmaster@example.com" ...
```

### Running

Then to run it:
```sh
$ docker run -v /var/run/docker.sock:/tmp/docker.sock:ro -v /srv/caddy/.caddy:/root/.caddy --name caddy-proxy -p 80:80 -p 443:443 -e CADDY_OPTIONS="--email webmaster@example.com" -d jshmrtn/caddy-proxy:0.2.1
```
