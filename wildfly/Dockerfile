# Use latest Fedora image as the base
FROM fedora:latest

# Update base image
# xmlstarlet is useful when modifying attributes/elements
# saxon can be used to execute configuration transformation using XSLT
# augeas is a great tool to edit any configuration files (XML too)
# bsdtar can be used to unpack zip files using pipes
RUN yum -y update \
	&& yum -y install java-1.7.0-openjdk-devel xmlstarlet saxon augeas bsdtar \
	&& yum clean all \
        && groupadd -r wildfly -g 433 \
	&& useradd -u 431 -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly user" wildfly

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/wildfly

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 8.1.0.Final

# Create directory to extract tar file to
# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN mkdir /opt/wildfly-$WILDFLY_VERSION \
	&& cd /opt && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx \
	&& chown -R wildfly:wildfly /opt/wildfly-$WILDFLY_VERSION \
	&& ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly \
	&& chown -R wildfly:wildfly /opt/wildfly

# Expose the ports we're interested in
EXPOSE 8080 9990

# Run everything below as the wildfly user
USER wildfly

# Set the default command to run on boot
VOLUME ["/opt/wildfly/override"]

# The script used to boot wildfly
COPY docker-entrypoint.sh /opt/wildfly/bin/docker-entrypoint.sh

# Needs some improvement, to handle starting in domain mode
CMD ["/opt/wildfly/bin/docker-entrypoint.sh"]
