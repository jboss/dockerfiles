#!/bin/bash

OVERRIDE="/opt/wildfly/override"
SERVER_MODE=${SERVER_MODE:-standalone}

if [ "${SERVER_MODE}" != "standalone" -a "${SERVER_MODE}" != "domain" ] ; then
	echo "The SERVER_MODE has to either be 'standalone' or 'domain'. It was: '${SERVER_MODE}'"
fi

# if a standalone.xml is available at the overrides directory, it uses that
for mode in standalone domain ; do 
	if [ -f "${OVERRIDE}/${mode}/configuration/${mode}.xml" ] ; then
		echo "Using the ${mode}.xml from the override"
		rm -f /opt/wildfly/${mode}/configuration/${mode}.xml 
		ln -s ${OVERRIDE}/${mode}/configuration/${mode}.xml /opt/wildfly/${mode}/configuration/${mode}.xml
	fi


	if [ -d "${OVERRIDE}/${mode}/deployments" ] ; then
		echo "Using ${mode}/deployments directory from the override"
		if [ -d /opt/wildfly/${mode}/deployments ] ; then rm -rf /opt/wildfly/${mode}/deployments ; fi
		ln -s ${OVERRIDE}/${mode}/deployments /opt/wildfly/${mode}/deployments 
	fi
done

# starts in ${SERVER_MODE} mode, or standalone as default
/opt/wildfly/bin/${SERVER_MODE}.sh -b 0.0.0.0 -bmanagement 0.0.0.0
