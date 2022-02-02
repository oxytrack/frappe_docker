#ARG IMAGE_TAG=develop
ARG IMAGE_TAG=version-13
ARG DOCKER_REGISTRY_PREFIX=frappe
FROM ${DOCKER_REGISTRY_PREFIX}/erpnext-worker:${IMAGE_TAG}

#ARG GIT_REPO=https://github.com/frappe/erpnext
# ARG GIT_REPO=https://github.com/oxytrack/oxytrack
ARG GIT_REPO=https://wfcurti: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@github.com/oxytrack/oxytrack
#ARG GIT_BRANCH=develop
# ARG GIT_BRANCH=version-13


USER root
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

USER frappe
# RUN install_app oxytrack ${GIT_REPO} ${GIT_BRANCH}
RUN install_app oxytrack ${GIT_REPO}

