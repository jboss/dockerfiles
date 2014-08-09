# Use latest abstractj/as7 image as the base
FROM jboss/aerogear-as7
MAINTAINER Bruno Oliveira <bruno@abstractj.org>

# Run everything below as aerogear user
USER aerogear

# Switch to the working dir $JBOSS_HOME/standalone/deployments
WORKDIR /opt/aerogear/server/standalone/deployments

# Download binary file for the auth-server with Keycloak
RUN wget --quiet https://s3-eu-west-1.amazonaws.com/hamster.abstractj.org/as7/auth-server.war

# Download binary file for the UnifiedPush server
RUN wget --quiet https://s3-eu-west-1.amazonaws.com/hamster.abstractj.org/as7/ag-push.war
