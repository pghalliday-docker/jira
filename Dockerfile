FROM ubuntu:latest

ENV ATLASSIAN_HOME=/var/atlassian/application-data \
    JIRA_USER=jira \
    JIRA_GROUP=jira \
    JIRA_CHECKSUM=c979f112069594ab743c35193d915b42b8a5423e2a934b6adb0548d4556bbb99 \
    JIRA_BASENAME=atlassian-jira-6.4 \
    JIRA_INSTALL_DIR=/opt/atlassian/jira

ENV JIRA_HOME=${ATLASSIAN_HOME}/jira \
    JIRA_TARBALL=${JIRA_BASENAME}.tar.gz

ENV JIRA_URL=https://www.atlassian.com/software/jira/downloads/binary/${JIRA_TARBALL}

RUN apt-get update \
    && apt-get install -y \
    wget \
    openjdk-7-jre

RUN mkdir -p ${ATLASSIAN_HOME} \
    && groupadd -r ${JIRA_GROUP} \
    && useradd -r -g ${JIRA_GROUP} -d ${JIRA_HOME} ${JIRA_USER} \
    && mkdir -p ${JIRA_INSTALL_DIR}

WORKDIR ${JIRA_INSTALL_DIR}
RUN wget -q ${JIRA_URL} \
    && echo ${JIRA_CHECKSUM} ${JIRA_TARBALL} | sha256sum -c - \
    && tar zxf ${JIRA_TARBALL} \
    && rm ${JIRA_TARBALL} \
    && ln -s ${JIRA_BASENAME}-standalone current \
    && chown -R ${JIRA_USER}:${JIRA_GROUP} current/logs \
    && chown -R ${JIRA_USER}:${JIRA_GROUP} current/temp \
    && chown -R ${JIRA_USER}:${JIRA_GROUP} current/work

COPY jira-server.xml /
COPY jira-seraph-config.xml /
COPY jira-crowd.properties /
COPY docker-entrypoint.sh /
VOLUME ${JIRA_HOME}
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${JIRA_INSTALL_DIR}/current/bin
EXPOSE 8080
CMD ./start-jira.sh -fg
