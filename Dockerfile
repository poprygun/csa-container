FROM alpine:latest

ARG SSH_KEY_GITLAB_DEPLOY_KEY

RUN apk add wget \
    && apk add git \
    && apk add openssh-client

RUN wget https://github.com/vmware-tanzu/cloud-suitability-analyzer/releases/download/v3.2.8-rc1/csa-l -P /bin \
    && chmod a+x /bin/csa-l \
    && ln -s /bin/csa-l /bin/csa

RUN \
    ### ssh configuration, see https://docs.gitlab.com/ee/ci/ssh_keys/#ssh-keys-when-using-the-docker-executor
    # run ssh-agent inside build environment
    eval $(ssh-agent -s); \
    # add ssh-key from GitLab variable to ssh agent store incl. fixing line endings
    echo "${SSH_KEY_GITLAB_DEPLOY_KEY}" | tr -d '\r' | ssh-add -; \
    # create the SSH directory and give it the right permissions
    mkdir -p ~/.ssh; \
    # Allow access to gitlab.your.lan
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config; \
    chmod 700 ~/.ssh; \
    \
    git clone git@gitlab.eng.vmware.com:vmware-navigator-practice/tooling/csa-rules.git;

WORKDIR /

# ENTRYPOINT ["csa-l"]
SHELL ["/bin/bash", "-c"]