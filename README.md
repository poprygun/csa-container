# CSA Container

Streamline the setup end configuration of CSA tool

## Current distribution of the image is pulling rules from [Github repository](https://github.com/vmware-tanzu/cloud-suitability-analyzer/tree/master/rules)

```bash
docker build . --pull --rm -t ashuimilov/csa
```

## In the future, Pull CSA rules from Gitlab private repository

In the future, CSA Rules will be maintained in `git@gitlab.eng.vmware.com:vmware-navigator-practice/tooling/csa-rules.git`

Follow instructions below to update Dockerfile and build an image specifying gitlab deploy key when switching to use private repository

In Dockerfile:

```lang-sh
RUN \
    eval $(ssh-agent -s); \
    echo "${SSH_KEY_GITLAB_DEPLOY_KEY}" | tr -d '\r' | ssh-add -; \
    mkdir -p ~/.ssh; \
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config; \
    chmod 700 ~/.ssh; \
    \
    git clone git@gitlab.eng.vmware.com:vmware-navigator-practice/tooling/csa-rules.git;
```

```bash
docker build . --force-rm -t ashuimilov/csa --build-arg SSH_KEY_GITLAB_DEPLOY_KEY="-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
"
```

```bash
docker run -it -v $(pwd)/to-delete:/projects -p 3001:3001 --rm ashuimilov/csa
```

UI is available on [mapped port](http://localhost3001)
