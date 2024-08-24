# Sysbox Jammy Workstation

## Run a Workstation Container
```bash
docker run --runtime=sysbox-runc -it -d --rm \
    -p=127.0.0.1:2222:22 \
    -p=127.0.0.1:8080:80 \
    --hostname=sysbox-jammy-host \
    --name=sysbox-jammy-container \
    cedricanover94/sysbox-jammy:latest
```

---

## SSH to the Workstation Container
```shell
ssh <username>@127.0.0.1 -p 2222
```

---

## Build
```shell
$ ./build.sh <username> <password>
# Or
$ DOCKER_HUB_USERNAME='<dockerhub_username>' DOCKER_HUB_PUSH='<yes|no>' ./build.sh <username> <password>
```
