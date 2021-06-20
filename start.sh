#!/bin/sh

# set keyvault uri in system properties
if [ -n "$azure_keyvault_uri" ]; then
  export JAVA_ARGS=-Dazure.keyvault.uri=$azure_keyvault_uri $JAVA_ARGS
  export AZURE_ARGS="-keyStoresType AZURE -keyvaultUri $azure_keyvault_uri -keyvaultTennantId $azure_keyvault_tennantid -keyvaultClientId $azure_keyvault_clientid -keyvaultClientSecret $azure_keyvault_client_secret"
fi

java -Dlog4j.configurationFile=/ebms/log4j2.xml $JAVA_ARGS -cp ${JDBCJAR}:ebms-admin-${VERSION}.jar nl.clockwork.ebms.admin.StartEmbedded $AZURE_ARGS $@