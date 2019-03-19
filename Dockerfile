FROM node:10
FROM openjdk:8
FROM gcr.io/cloud-builders/gcloud-slim@sha256:7e910b97dd13d8e32acb3e53c5f4d2164c5ea8e93de1ea51e610a1112fa6308e

LABEL version="0.0.1"
LABEL repository="http://github.com/actions/npm"
LABEL homepage="http://github.com/actions/npm"
LABEL maintainer="Informaticon AG <mobile@informaticon.com>"

LABEL com.github.actions.name="GitHub Action for GCP Script execution"
LABEL com.github.actions.description="Wraps the ssr CLI to enable common ssr commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="red"
# COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

ENV DOCKERVERSION=18.06.1-ce
RUN apt-get update \
  && apt-get -y --no-install-recommends install curl \
  && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz \
  && rm -rf /var/lib/apt/lists/* \
  && npm i -g @informaticon/devops.sql-script-runner

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
