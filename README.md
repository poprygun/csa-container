# csa-container

```bash
docker build --pull --rm -t ashuimilov/csa

docker build . --force-rm -t ashuimilov/csa --build-arg SSH_KEY_GITLAB_DEPLOY_KEY="-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
"

```

```bash
docker run -it --rm ashuimilov/csa
```