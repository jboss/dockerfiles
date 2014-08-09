# JBoss AS7 Docker image

This is an example Dockerfile with [JBoss AS7 application server](http://jboss.org/).

## Usage

To boot in standalone mode

    docker run -it jboss/as7

To boot in domain mode

    docker run -it jboss/as7 /opt/jboss/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0

### Acessing JBoss AS7

Get the image IP address, for example:

`boot2docker ip` or `docker inspect IMAGENAME | grep -i IPAdr`

Run:

`docker run -it -p 8080:8080 -p 8443:8443 jboss/as7`

Access it:

- HTTP

`https://myip:8080/`

- HTTPS

`https://myip:8443/`

*Note*: The SSL certificate is automatically generated and self-signed

## Building on your own

You don't need to do this on your own, because we prepared a trusted build for this repository, but if you really want:

    docker build --rm=true --tag=jboss/as7 .

## Source

The source is [available on GitHub](https://github.com/jboss/dockerfiles/tree/master/as7).

## Issues

Please report any issues or file RFEs on [GitHub](https://github.com/jboss/dockerfiles/issues).
