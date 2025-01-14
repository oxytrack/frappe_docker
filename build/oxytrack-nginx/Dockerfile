ARG NODE_IMAGE_TAG=14-bullseye-slim
# ARG NODE_IMAGE_TAG=14-bitnami/node:12-prod

# ARG IMAGE_TAG=version-13
# ARG DOCKER_REGISTRY_PREFIX=frappe
# ARG IMAGE_TAG=v0.0.2
# ARG DOCKER_REGISTRY_PREFIX=europe-west6-docker.pkg.dev/oxytrack-322814/oxytrack-docker-repo
ARG IMAGE_TAG=version-13
ARG DOCKER_REGISTRY_PREFIX=frappe

FROM node:${NODE_IMAGE_TAG} as builder
# FROM node:${NODE_IMAGE_TAG}

ARG GIT_REPO=git@github.com:oxytrack/oxytrack

#ARG GIT_BRANCH=develop
ARG GIT_BRANCH=version-13
ARG APP_BRANCH=main

ARG FRAPPE_BRANCH=${GIT_BRANCH}

ARG SSH_PRIVATE_KEY

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    python2 \
    git \
    build-essential \
    ca-certificates \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Make ssh dir
RUN mkdir -p /root/.ssh
# Copy over private key, and set permissions
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
# RUN chown -R root:root /root/.ssh
# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Remove host checking
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

COPY build/oxytrack-nginx/install_app.sh /install_app
RUN chmod +x /install_app \
    && /install_app oxytrack ${GIT_REPO} ${APP_BRANCH} ${FRAPPE_BRANCH}
    # && /install_app oxytrack ${GIT_REPO} ${GIT_BRANCH} ${FRAPPE_BRANCH}

FROM ${DOCKER_REGISTRY_PREFIX}/erpnext-nginx:${IMAGE_TAG}

COPY --from=builder --chown=1000:1000 /home/frappe/frappe-bench/sites/ /var/www/html/
COPY --from=builder /rsync /rsync

RUN echo -n "\noxytrack" >> /var/www/html/apps.txt

VOLUME [ "/assets" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
