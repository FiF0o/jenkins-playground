# Jenkins playground

# Setup

## prereq

- Download Jenkins install
- Setup Jenkins
- Check `JAVA_HOME` & `PATH` for java - ```java --version```
- Install Jenkins: - [download](https://www.jenkins.io/download/lts/macos/), _(homebrew is required)_.


### Jenkins setup local

Run jenkins with brew - commands are available in Makefile.

- View Jenkins dashboard: `open http://localhost:8080`
- set admin password: `pw=$(cat ~/.jenkins/secrets/initialAdminPassword) && echo "export JENKINS_ROOT_PASSWORD=\"$pw\"" >> .env`.
- get pw: `cat ~/.jenkins/secrets/initialAdminPassword| pbcopy`
- create user

### Jenkins setup docker containers

3 containers are required: jenkins-docker (Execute docker cmds inside jenkins nodes), jenkins-blueocean (jenkins controller,UI), agent (jenkins agent/nodes to run tasks)

- [Steps](https://www.jenkins.io/doc/book/installing/docker/)

```sh
# Run docker container to :dind
docker network create jenkins

docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2
```

```sh
# Build image

docker build -t myjenkins-blueocean:2.492.2-1 .
## View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/22ia4w6rtdnka4nhtkf262ceu

# Run myjenkins-blueocean:2.492.2-1 container
docker run \
  --name jenkins-blueocean \
  --restart=on-failure \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.492.2-1

# Login and setup user

docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword | pbcopy

open http://localhost:8080/
```

### Setup node/agent instead of running tasks in controller

```sh
# Create ssh key and jenkins docker agent to run on the same network
## https://www.jenkins.io/doc/book/using/using-agents/
# https://github.com/jenkinsci/docker-ssh-agent

# Create ssh key

docker run -d --rm --name=agent --publish 2200:22 --network=jenkins -e "JENKINS_AGENT_SSH_PUBKEY=$(cat ~/.ssh/jenkins_agent_key.pub)" jenkins/ssh-agent 


docker container inspect agent | grep '"IPAddress"'

#  Configure agent

## http://localhost:8080/computer/agent/
## http://localhost:8080/computer/agent/log

# Run job with agent
## http://localhost:8080/job/job-for-agent/1/console
```