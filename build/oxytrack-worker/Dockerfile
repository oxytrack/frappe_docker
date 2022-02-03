#ARG IMAGE_TAG=develop
ARG IMAGE_TAG=version-13
ARG DOCKER_REGISTRY_PREFIX=frappe
FROM ${DOCKER_REGISTRY_PREFIX}/erpnext-worker:${IMAGE_TAG}

#ARG GIT_REPO=https://github.com/frappe/erpnext
# ARG GIT_REPO=https://github.com/oxytrack/oxytrack
ARG GIT_REPO=git@github.com:oxytrack/oxytrack

#ARG GIT_BRANCH=develop
# ARG GIT_BRANCH=version-13

ARG SSH_PRIVATE_KEY

USER root
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    # gcc \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
# ADD build/github-ssh/id_rsa /root/.ssh/id_rsa
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN chown -R root:root /root/.ssh

# Create known_hosts
RUN touch /root/.ssh/known_hosts

# Remove host checking
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# USER frappe
# RUN install_app oxytrack ${GIT_REPO} ${GIT_BRANCH}
RUN install_app oxytrack ${GIT_REPO}

