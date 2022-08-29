FROM alpine:latest

ARG SSH_KEY_GITLAB_DEPLOY_KEY

RUN apk add wget \
    && apk add git \
    && apk add openssh-client

RUN wget https://github.com/vmware-tanzu/cloud-suitability-analyzer/releases/download/v3.2.8-rc1/csa-l -P /bin \
    && chmod a+x /bin/csa-l \
    && ln -s /bin/csa-l /bin/csa

RUN \
    git clone https://github.com/vmware-tanzu/cloud-suitability-analyzer.git \
    && ln -s /cloud-suitability-analyzer/rules /csa-rules

WORKDIR /projects

RUN csa bins export && \
    csa rules import –-rules-dir=/csa-rules && \
    csa -p .


# ENTRYPOINT ["csa-l"]
SHELL ["/bin/bash", "-c"]