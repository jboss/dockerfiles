# Use latest Fedora image as the base
FROM fedora

# xmlstarlet is useful when modifying attributes/elements
# saxon can be used to execute configuration transformation using XSLT
# augeas is a great tool to edit any configuration files (XML too)
RUN yum -y install java-1.7.0-openjdk-devel xmlstarlet saxon augeas

# Clean the metadata
RUN yum clean all

# Set the JBOSS_VERSION env variable
ENV JBOSS_VERSION 7.1.1.Final

# Add the WildFly distribution to /opt
RUN cd /opt && curl http://download.jboss.org/jbossas/7.1/jboss-as-$JBOSS_VERSION/jboss-as-$JBOSS_VERSION.tar.gz | tar zx

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/jboss-as-$JBOSS_VERSION /opt/jboss

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss

# Disable requiretty
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

# Create the as7 user and group
RUN groupadd -r jboss -g 433 && useradd -u 431 -r -g jboss -d /opt/jboss -s /sbin/nologin -c "JBoss AS7 user" jboss

# Allows jboss user to run keytool and yum with sudo
RUN echo "jboss ALL=NOPASSWD:/usr/bin/keytool" >> /etc/sudoers

# Change the owner of the /opt/as7 directory
RUN chown -R jboss:jboss /opt/jboss*

# Wildfly configuration file ready for HTTPS
ADD configuration/xml/standalone-sample.xml $JBOSS_HOME/standalone/configuration/standalone.xml

# Add the certificate.sh script into $JBOSS_HOME/standalone/configuration/certs
ADD configuration/certs/ $JBOSS_HOME/standalone/configuration/certs

# Switch to $JBOSS_HOME/configuration/certs
WORKDIR /opt/jboss/standalone/configuration/certs

# Execute the script to generate self signed certificates
RUN ./certificate.sh

# Switch to the working dir /opt/jboss
WORKDIR /opt/jboss

# Expose the ports we're interested in
EXPOSE 8080 8443 9990

# Run everything below as the as7 user
USER jboss

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
