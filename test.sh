#!/bin/bash

set -e

NEW_USERNAME='developer'
NEW_PASSWORD='developer'
TEST_CONTAINER_NAME='test-sysbox-workstation'


echo "[TEST] Building..."
docker image prune -f
BASE_IMG_NAME="$TEST_CONTAINER_NAME" USE_SSH_PASSWD_AUTH='no' ./build.sh $NEW_USERNAME $NEW_PASSWORD
docker image prune -f
echo "[TEST] Done Building."

echo "[TEST] Creating Container..."
docker run --runtime=sysbox-runc -it -d --rm \
    -p=127.0.0.1:2222:22 \
    -p=127.0.0.1:8081:80 \
    -p=127.0.0.1:8080:8080 \
    --hostname=$TEST_CONTAINER_NAME \
    --name=$TEST_CONTAINER_NAME \
    cedricanover94/$TEST_CONTAINER_NAME:latest

sleep 2

echo "[TEST] Obtaining SSH Private Key..."
echo "$(docker exec $TEST_CONTAINER_NAME cat /home/$NEW_USERNAME/.ssh/id_rsa)" > id_rsa
chmod 600 ./id_rsa

echo "[TEST] Executing SSH Command..."
ssh -i './id_rsa' $NEW_USERNAME@127.0.0.1 -p 2222 'pwd' || true

docker kill $TEST_CONTAINER_NAME &> /dev/null
rm id_rsa || true
echo "[TEST] Done."
