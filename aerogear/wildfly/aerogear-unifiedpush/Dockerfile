# Use latest jboss/wildfly image as the base
FROM jboss/aerogear-wildfly
MAINTAINER Bruno Oliveira <bruno@jboss.org>

# Run everything below as aerogear user
USER aerogear

# Switch to the working dir $JBOSS_HOME/standalone/deployments
WORKDIR /opt/wildfly/standalone/deployments

# Download binary file for the auth-server with Keycloak
RUN wget --quiet https://s3-eu-west-1.amazonaws.com/hamster.jboss.org/wildfly/ag-push.war

# Download binary file for the UnifiedPush server
RUN wget --quiet https://s3-eu-west-1.amazonaws.com/hamster.jboss.org/wildfly/auth-server.war
