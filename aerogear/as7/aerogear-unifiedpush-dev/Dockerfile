# Use latest jboss/as7 image as the base
FROM jboss/aerogear-as7
MAINTAINER Bruno Oliveira <bruno@jboss.org>

# Set the repository name
ENV REPO_NAME aerogear-unifiedpush-server

# Set MAVEN_OPTS to increase the amount of memory available for Maven
ENV MAVEN_OPTS -Xmx768m -XX:+UseConcMarkSweepGC -XX:MaxPermSize=128m -XX:+CMSPermGenSweepingEnabled

# Node environment variable
ENV NPM_MODULES_HOME /opt/aerogear/node_modules/

# Java environment variable
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk

# Set the Maven version
ENV MAVEN_VERSION 3.2.2

# Set M2_HOME directory
ENV M2_HOME /opt/aerogear/tools/maven

# General system variable setup
ENV PATH $JAVA_HOME/bin:$M2_HOME/bin:$NPM_MODULES_HOME/.bin:$NODE_HOME/bin:$PATH

# Run everything below as root user
USER root

# Allows aerogear user to run npm as sudo
RUN echo "aerogear ALL=NOPASSWD:/usr/bin/npm" >> /etc/sudoers

# Run everything below as aerogear user
USER aerogear

# Install the dependencies required for Node.js
RUN sudo yum install -q -y nodejs npm gcc make libpng libpng-devel git && yum -q clean all

# Clean the cache
RUN npm cache clear

# Install Node.js modules globally
RUN sudo npm install -g grunt-cli bower@1.3.8 node-gyp

# Switch to the working dir /opt/aerogear
WORKDIR /opt/aerogear

# Create directory tools for Maven download
RUN mkdir tools

# Download Maven
RUN wget --quiet http://ftp.unicamp.br/pub/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz

# Create /opt/aerogear/tools/maven and extract Maven content
RUN mkdir $M2_HOME && tar xzf apache-maven-$MAVEN_VERSION-bin.tar.gz --strip 1 -C $M2_HOME

# Remove downloaded files
RUN rm -f $HOME/*.tar.gz

# Clone UnifiedPush server from the official repository
RUN git clone https://github.com/aerogear/$REPO_NAME.git

# Switch to the cloned repository and run Maven install
RUN cd $REPO_NAME && mvn clean install -DskipTests=true

# Switch to server directory from UnifiedPush
WORKDIR /opt/aerogear/aerogear-unifiedpush-server/servers

# Copy binary file for the auth-server with Keycloak to deployments folder
RUN cp auth-server/target/*.war $JBOSS_HOME/standalone/deployments

# Copy binary file for the UnifiedPush server to deployments folder
RUN cp ups-as7/target/*.war $JBOSS_HOME/standalone/deployments
