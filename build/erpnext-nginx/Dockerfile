ARG NODE_IMAGE_TAG=14-bullseye-slim
#ARG IMAGE_TAG=develop
ARG IMAGE_TAG=version-13
ARG DOCKER_REGISTRY_PREFIX=frappe
# ARG IMAGE_TAG=v0.0.2
# ARG DOCKER_REGISTRY_PREFIX=europe-west6-docker.pkg.dev/oxytrack-322814/oxytrack-docker-repo

FROM node:${NODE_IMAGE_TAG} as builder

ARG GIT_REPO=https://github.com/frappe/erpnext
# ARG GIT_REPO=https://github.com/oxytrack/erpnext
#ARG GIT_BRANCH=develop
ARG GIT_BRANCH=version-13


ARG FRAPPE_BRANCH=${GIT_BRANCH}

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    python2 \
    git \
    build-essential \
    ca-certificates \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

COPY build/erpnext-nginx/install_app.sh /install_app
RUN chmod +x /install_app \
    && /install_app erpnext ${GIT_REPO} ${GIT_BRANCH} ${FRAPPE_BRANCH}


FROM ${DOCKER_REGISTRY_PREFIX}/frappe-nginx:${IMAGE_TAG}

COPY --from=builder --chown=1000:1000 /home/frappe/frappe-bench/sites/ /var/www/html/
COPY --from=builder /rsync /rsync

RUN echo "erpnext" >> /var/www/html/apps.txt

VOLUME [ "/assets" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
