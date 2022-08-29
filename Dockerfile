FROM alpine:latest

RUN apk add wget

RUN wget https://github.com/vmware-tanzu/cloud-suitability-analyzer/releases/download/v3.2.8-rc1/csa-l -P /bin \
    && chmod a+x /bin/csa-l \
    && ln -s /bin/csa-l /bin/csa

WORKDIR /

# ENTRYPOINT ["csa-l"]
SHELL ["/bin/bash", "-c"]