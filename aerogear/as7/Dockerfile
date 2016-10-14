# Use latest Fedora image as the base
FROM fedora
MAINTAINER Bruno Oliveira <bruno@abstractj.org>

# Disable requiretty to prevent Node.js sessions hangup
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

# Install OpenJDK and wget for AS7 images and clean the metadata
RUN sudo yum -q -y install java-1.7.0-openjdk-devel wget && yum -q clean all

# Set the HOME environment variable
ENV HOME /opt/aerogear

# Set the Java environment variable
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk

# Set the JBoss environment variable
ENV JBOSS_HOME /opt/aerogear/server

# Set the JBoss AS7 version
ENV JBOSS_VERSION 7.1.1.Final

# Run everything below as root user
USER root

# Create the aerogear user
RUN useradd -m aerogear -d /opt/aerogear -s /sbin/nologin

# Change owner of the /opt/aerogear directory
RUN chown -R aerogear /opt/aerogear

# Change group of the /opt/aerogear directory
RUN chgrp -R users /opt/aerogear

# Allows aerogear user to run keytool and yum with sudo
RUN echo "aerogear ALL=NOPASSWD:/usr/bin/keytool,/usr/bin/yum" >> /etc/sudoers

# Rename the original configuration file
RUN mv $JBOSS_HOME/standalone/configuration/standalone.xml $JBOSS_HOME/standalone/configuration/standalone.xml.orig

# Switch to the working dir /opt/aerogear
WORKDIR /opt/aerogear

# Download JBoss AS7
RUN wget --quiet http://download.jboss.org/jbossas/7.1/jboss-as-$JBOSS_VERSION/jboss-as-$JBOSS_VERSION.tar.gz

# Create /opt/aerogear/server and extract the server
RUN mkdir -p $JBOSS_HOME && tar xzvf jboss-as-$JBOSS_VERSION.tar.gz --strip 1 -C $JBOSS_HOME

# Remove downloaded files
RUN rm -f $HOME/*.tar.gz

# JBoss AS7 configuration file ready for HTTPS
ADD configuration/xml/standalone-sample.xml $JBOSS_HOME/standalone/configuration/standalone.xml

# Add the certificate.sh script into $JBOSS_HOME/standalone/configuration/certs
ADD configuration/certs/ $JBOSS_HOME/standalone/configuration/certs

# Add the database configuration file to $JBOSS_HOME/standalone/deployments
ADD configuration/database/unifiedpush-h2-ds.xml $JBOSS_HOME/standalone/deployments/

# Switch to $JBOSS_HOME/configuration/certs
WORKDIR /opt/aerogear/server/standalone/configuration/certs

# Execute the script to generate self signed certificates
RUN ./certificate.sh

# Switch to the working dir /opt/aerogear
WORKDIR /opt/aerogear/server

# Expose SSL default port
EXPOSE 8443

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
ENTRYPOINT ["/opt/aerogear/server/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
