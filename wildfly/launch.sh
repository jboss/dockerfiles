#!/bin/bash

JBOSS_HOME=/opt/wildfly

if [ $# -lt 1 ]; then
  echo "Usage: $0 <configuration> [options]"
  echo
  echo "Launches WildFly in the selected configuration with specified options (if any)"
  echo
  echo "<configuration>  - standalone or domain"
  echo "[options]        - options accepted by the standalone/domain.sh scripts"
  echo
  echo "Examples:"
  echo
  echo "*  To run WildFly in standalone mode with default options:"
  echo
  echo "   $0 standalone"
  echo
  echo "*  To run WildFly in standalone mode with custom options:"
  echo
  echo "   $0 standalone -b 0.0.0.0"
  exit 1
fi

if [ "$1" = "standalone" ] || [ "$1" = "domain" ]; then
  CONFIGURATION=$1
else
  echo "Only domain and standalone configuration are valid, you provided '$1'. Aborting."
  exit 1
fi

if [ "$1" = "standalone" ] && [ -z "$SELF_SIGNED_CERTIFICATE" ]; then
  mkdir -p $CONFIGURATION/configuration/certificate
  $JBOSS_HOME/bin/self-signed-certificate.sh $CONFIGURATION/configuration/certificate
  cp $CONFIGURATION/configuration/standalone.xml $CONFIGURATION/configuration/standalone.xml.orig

fi

shift 1

$JBOSS_HOME/bin/${CONFIGURATION}.sh $@

