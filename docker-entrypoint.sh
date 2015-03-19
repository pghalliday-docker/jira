#!/bin/bash

set -e

SERVER_XML=${JIRA_INSTALL_DIR}/current/conf/server.xml
SERAPH_CONFIG_XML=${JIRA_INSTALL_DIR}/current/atlassian-jira/WEB-INF/classes/seraph-config.xml
CROWD_PROPERTIES=${JIRA_INSTALL_DIR}/current/atlassian-jira/WEB-INF/classes/crowd.properties

if [ "${JIRA_PROXY_NAME}" != "" -a "${JIRA_PROXY_PORT}" != "" ]
then
  sed "s/PROXY_SETTINGS/proxyName=\"${JIRA_PROXY_NAME}\" proxyPort=\"${JIRA_PROXY_PORT}\"/g" </jira-server.xml >${SERVER_XML}
fi

if [ "${JIRA_CROWD_APPLICATION_NAME}" != "" \
  -a "${JIRA_CROWD_APPLICATION_PASSWORD}" != "" \
  -a "${JIRA_CROWD_BASE_URL}" != "" \
  -a "${JIRA_CROWD_SESSION_VALIDATION_INTERVAL}" != "" ]
then
  sed \
    -e "s/JIRA_CROWD_APPLICATION_NAME/${JIRA_CROWD_APPLICATION_NAME}/g" \
    -e "s/JIRA_CROWD_APPLICATION_PASSWORD/${JIRA_CROWD_APPLICATION_PASSWORD}/g" \
    -e "s|JIRA_CROWD_BASE_URL|${JIRA_CROWD_BASE_URL}|g" \
    -e "s/JIRA_CROWD_SESSION_VALIDATION_INTERVAL/${JIRA_CROWD_SESSION_VALIDATION_INTERVAL}/g" \
    </jira-crowd.properties >${CROWD_PROPERTIES}
  cp /jira-seraph-config.xml ${SERAPH_CONFIG_XML}
fi

chown -R ${JIRA_USER}:${JIRA_GROUP} ${JIRA_HOME}
su ${JIRA_USER} -c "$@"
