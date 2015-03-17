# jira

To build

```
docker build --rm --tag=pghalliday/jira .
```

To run

```
docker run -p 0.0.0.0:8080:8080 -i -t pghalliday/jira
```

Map the following volume to persist jira data

```
/var/atlassian/application-data/jira 
```
