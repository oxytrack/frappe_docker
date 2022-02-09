# ARG IMAGE_TAG=v0.0.2
# ARG DOCKER_REGISTRY_PREFIX=europe-west6-docker.pkg.dev/oxytrack-322814/oxytrack-docker-repo
#ARG IMAGE_TAG=develop
ARG IMAGE_TAG=version-13
ARG DOCKER_REGISTRY_PREFIX=frappe
FROM ${DOCKER_REGISTRY_PREFIX}/frappe-worker:${IMAGE_TAG}

ARG GIT_REPO=https://github.com/frappe/erpnext
# ARG GIT_REPO=https://github.com/oxytrack/erpnext
#ARG GIT_BRANCH=develop
ARG GIT_BRANCH=version-13


USER root
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    gcc \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

USER frappe
RUN install_app erpnext ${GIT_REPO} ${GIT_BRANCH}
