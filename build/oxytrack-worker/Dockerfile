ARG IMAGE_TAG=v0.0.2
ARG DOCKER_REGISTRY_PREFIX=europe-west6-docker.pkg.dev/oxytrack-322814/oxytrack-docker-repo
#ARG IMAGE_TAG=develop
# ARG IMAGE_TAG=version-13
# ARG DOCKER_REGISTRY_PREFIX=frappe
FROM ${DOCKER_REGISTRY_PREFIX}/erpnext-worker:${IMAGE_TAG}

ARG GIT_REPO=git@github.com:oxytrack/oxytrack
ARG GIT_BRANCH=main

ARG SSH_PRIVATE_KEY

USER root
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    gcc \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Make ssh dir
RUN mkdir /home/frappe/.ssh
# Copy over private key, and set permissions
RUN echo "${SSH_PRIVATE_KEY}" > /home/frappe/.ssh/id_rsa
RUN chmod 700 /home/frappe/.ssh/id_rsa
# RUN chown -R root:root /root/.ssh
# RUN chown -R frappe:frappe /home/frappe/.ssh
# Create known_hosts
RUN touch /home/frappe/.ssh/known_hosts
# Remove host checking
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/frappe/.ssh/config
RUN chown -R frappe:frappe /home/frappe

USER frappe
# RUN install_app oxytrack git@github.com:oxytrack/oxytrack
RUN install_app oxytrack ${GIT_REPO} ${GIT_BRANCH}