#!/bin/bash

# Usage:
# 1) ./build.sh <username> <password>
# 2) DOCKER_HUB_USERNAME='<dockerhub_username>' DOCKER_HUB_PUSH='<yes|no>' ./build.sh <username> <password>

set -e

NEW_USERNAME=$1
NEW_PASSWORD=$2

: ${DOCKER_HUB_USERNAME:='cedricanover94'}
: ${DOCKER_HUB_PUSH:='no'}
: ${BASE_IMG_NAME:='sysbox-jammy'}
: ${BASE_IMG_TAG:='latest'}
: ${USE_SSH_PASSWD_AUTH:='yes'}

FULL_IMG_NAME="$DOCKER_HUB_USERNAME/$BASE_IMG_NAME:$BASE_IMG_TAG"


# Build Sysbox Image
echo "Building $FULL_IMG_NAME ..."
export PASSWORD=$NEW_PASSWORD
export DOCKER_BUILDKIT=1
docker build -t $FULL_IMG_NAME \
    --secret id=newpass,env=PASSWORD \
    --build-arg NEW_USER=$NEW_USERNAME \
    --build-arg "USE_SSH_PASSWD_AUTH=$USE_SSH_PASSWD_AUTH" \
    --no-cache --progress='plain' .
docker image prune -f
echo "Build Complete: $FULL_IMG_NAME"


# Push Image to Docker Hub
push_yes_or_no=("yes" "no")
if printf "%s\n" "${push_yes_or_no[@]}" | grep -q -x "$DOCKER_HUB_PUSH"; then
    if [ $DOCKER_HUB_PUSH = 'yes' ]; then 
        echo "Pushing $FULL_IMG_NAME to Dockerhub..."; 
        docker push $FULL_IMG_NAME
        echo "$FULL_IMG_NAME successfully pushed"
        exit 0
    fi
else
    echo 'DOCKER_HUB_PUSH must either be "yes" or "no"'
    exit 1
fi
