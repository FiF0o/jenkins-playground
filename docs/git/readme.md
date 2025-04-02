# Git setup

## SCM

```sh
# 1.Create hello-world job

# 2.Configure job for public repo
## 2.1.Add project url
### e.g. https://github.com/FiF0o/jenkins-playground

## 2.2.Set git url
### https://github.com/FiF0o/jenkins-playground.git

## 2.3. set triggers
### JENKINS_URL/job/hello-world/build?token=TOKEN_NAME or /buildWithParameters?token=TOKEN_NAME
curl http://localhost:8080/job/hello-world/build?token=$TOKEN_NAME

## 2.4. set polling Poll SCM
### e.g every minute * * * * *

```