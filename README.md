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
JIRA_PROXY_NAME - the host name if using a reverse proxy
JIRA_PROXY_PORT - the port if using a reverse proxy
```
