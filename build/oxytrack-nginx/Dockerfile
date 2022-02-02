ARG NODE_IMAGE_TAG=14-bullseye-slim
ARG DOCKER_REGISTRY_PREFIX=frappe
#ARG IMAGE_TAG=develop
ARG IMAGE_TAG=version-13

FROM node:${NODE_IMAGE_TAG} as builder

#ARG GIT_REPO=https://github.com/frappe/erpnext
# ARG GIT_REPO=https://github.com/oxytrack/oxytrack
ARG GIT_REPO=https://wfcurti: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@github.com/oxytrack/oxytrack
# ARG GIT_REPO=git@github.com:wfcurti/oxytrack/oxytrack.git
#ARG GIT_BRANCH=develop
ARG GIT_BRANCH=version-13
ARG APP_BRANCH=


ARG FRAPPE_BRANCH=${GIT_BRANCH}

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    python2 \
    git \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

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
