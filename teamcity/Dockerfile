FROM java:8-jre
MAINTAINER Michał 'Griwes' Dominiak <griwes@griwes.info>

ARG PROXY=
ENV http_proxy ${PROXY}
ENV https_proxy ${PROXY}

RUN apt-get update && apt-get install apt-transport-https ca-certificates -y && rm -rf /var/lib/apt/lists/* \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list
 
RUN apt-get update && apt-get install -y git subversion docker-engine python libgit2-dev python-dev python-pip netcat-openbsd && rm -rf /var/lib/apt/lists/*
RUN pip install pygit2==0.21.0 slumber

ADD entry.sh /entry.sh
CMD bash /entry.sh
