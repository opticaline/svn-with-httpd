# Supported tags
- 2.4.48-1.9.7-r0, 2.4.48, latest
# How to use this image.
## to run a new container
```shell
docker run -d --name svn -p 8080:80 opticaline/svn-with-httpd:latest
```
## open shell in container
```shell
docker exec -it svn sh
```
## to create new user
```shell
htpasswd -b /etc/subversion/passwd user pass
```
## to create new repository
```shell
svnadmin create /home/svn/{REPOSITORY_NAME}
chmod -R 777 /home/svn/{REPOSITORY_NAME}/db
```
