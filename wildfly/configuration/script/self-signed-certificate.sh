#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <destination path> [options]"
  echo
  echo "[options] - options accepted by the certificate script"
  echo
  echo "*  To generate self signed certificates for the first time:"
  echo
  echo "   $0 $JBOSS_HOME/configuration/certificates"
  echo
  echo "*  To override self signed certificates"
  echo
  echo "   $0 $JBOSS_HOME/configuration/certificates --override"
  echo
  exit 1
fi

if [ -d "$1" ] && [ ! -f "$CERT_FILE" ]; then

  if [ ! -f "$CERT_FILE" ]; then

    DOMAIN="wildfly.dev"
    SERVER_PASSWORD=$(head -c 2000 /dev/urandom | tr -dc a-z0-9A-Z | head -c 256)
    CERT_FILE="$1/server.$DOMAIN.keystore"

    sudo keytool -genkey -noprompt -alias server.$DOMAIN -keyalg RSA -keysize 2048 -keystore $CERT_FILE -storepass $SERVER_PASSWORD -keypass $SERVER_PASSWORD -validity 365 -dname "C=US,ST=North Carolina,O=Red Hat,L=Raleigh,CN=server.wildfly.dev,OU=DEVELOPMENT,emailAddress=wildfly@wildfly.org"
    sed "s/weak42/$SERVER_PASSWORD/g" $JBOSS_HOME/standalone/configuration/self-signed-certificate-configuration.xml > $JBOSS_HOME/standalone/configuration/standalone.xml
  else
    echo "Self signed certificate $CERT_FILE already exists. Aborting."
    exit 1
  fi

else
  echo "Path '$1' does not exist. Aborting."
  exit 1
fi
