# jira

To build

```
docker build --rm --tag=pghalliday/jira .
```

To run

```
docker run -p 0.0.0.0:8080:8080 -i -t pghalliday/jira
```

Mounts the following volume for persistent data

```
/var/atlassian/application-data/jira 
```

Set the following environment variables to configure the server

```
# to configure a reverse proxy front end

JIRA_PROXY_NAME - the host name if using a reverse proxy
JIRA_PROXY_PORT - the port if using a reverse proxy

# to configure SSO with Crowd

JIRA_CROWD_APPLICATION_NAME - the application name configured in Crowd for this JIRA instance
JIRA_CROWD_APPLICATION_PASSWORD - the password configured in Crowd for this JIRA instance
JIRA_CROWD_BASE_URL - the Crowd base url (remember to include the `/crowd` suffix, eg. 'http://crowd.test.net/crowd', don't add a trailing slash)
JIRA_CROWD_SESSION_VALIDATION_INTERVAL - the number of minutes between requests to check if still logged in with Crowd ('0' is every request but increases load on Crowd server)
```
