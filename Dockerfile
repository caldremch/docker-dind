FROM alpine
LABEL org.opencontainers.image.authors="<finishmoend@gmail.cn>"
# Install Docker CLI
USER root
RUN  mkdir -p /app/build
WORKDIR /app/build
COPY daemon_proccess.sh .
RUN apk add curl
RUN curl -o docker-latest.tgz https://download.docker.com/linux/static/stable/x86_64/docker-23.0.1.tgz
RUN  tar zxvf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz
# Change the group ID of user 'root' to the group ID of the host 'docker' group to have the permission to execute the 'docker' command
ARG DOCKER_GID=994
USER root:${DOCKER_GID}
VOLUME ['/app/build',"/var/run", "/projects-cache", "/build-cache"]
#RUN deamon
RUN nohup daemon_proccess.sh &