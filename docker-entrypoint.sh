#!/bin/bash

set -e

SOURCE_SERVER_XML=/jira-server.xml
SERVER_XML=${JIRA_INSTALL_DIR}/current/conf/server.xml
if [ "${JIRA_PROXY_NAME}" != "" -a "${JIRA_PROXY_PORT}" != "" ]
then
  sed "s/PROXY_SETTINGS/proxyName=\"${JIRA_PROXY_NAME}\" proxyPort=\"${JIRA_PROXY_PORT}\"/g" <${SOURCE_SERVER_XML} >${SERVER_XML}
else
  sed 's/PROXY_SETTINGS//g' <${SOURCE_SERVER_XML} >${SERVER_XML}
fi

chown -R ${JIRA_USER}:${JIRA_GROUP} ${JIRA_HOME}
su ${JIRA_USER} -c "$@"
