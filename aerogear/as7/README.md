# AeroGear AS7 Docker image

This base image prepare [AS7](http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz) environment to successfully deploy AeroGear projects, as well the required configuration.

## Install Docker

Follow the [instructions](http://docs.docker.com/installation/)


## Building the image

**Note**: Is not necessary to build this image, unless you're planning to extend it.

Clone the repo and build yourself:

`docker build -t jboss/aerogear-as7 .`

## Accessing it

Get the image IP address, for example:

`boot2docker ip`

Access it:

It only exposes SSL port, all the requests will redirect to https.

`https://myip:8443/`

*Note*: The SSL certificate is automatically generated and self-signed

## Contributing

Patches are welcome, just send a pull request and I will be happy on merging it. If you want more images, open issues
with the request.
