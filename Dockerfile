
FROM gcr.io/cloud-builders/gcloud-slim@sha256:7e910b97dd13d8e32acb3e53c5f4d2164c5ea8e93de1ea51e610a1112fa6308e

LABEL version="0.0.1"
LABEL repository="http://github.com/actions/npm"
LABEL homepage="http://github.com/actions/npm"
LABEL maintainer="Informaticon AG <mobile@informaticon.com>"

LABEL com.github.actions.name="GitHub Action for GCP Script execution"
LABEL com.github.actions.description="Wraps the ssr CLI to enable common ssr commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="red"

ENV DOCKERVERSION=18.06.1-ce

# install curl
RUN apt-get -y --no-install-recommends install curl

# install docker (google cloud)
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz
RUN tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker
RUN rm docker-${DOCKERVERSION}.tgz

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && \
    apt-get -y --no-install-recommends install nodejs && \
    rm -rf /var/lib/apt/lists/*
RUN npm version

# install script runner
RUN npm i -g @informaticon/devops.sql-script-runner@2.1.2

# Install OpenJDK-8
RUN apt-get update && \
    apt-get -y --no-install-recommends install openjdk-8-jdk && \
    apt-get -y --no-install-recommends install ant && \
    rm -rf /var/lib/apt/lists/*

# Fix certificate issues
RUN apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates-java && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# test java isntallation
RUN java -version

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
