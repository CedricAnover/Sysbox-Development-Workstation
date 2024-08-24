FROM nestybox/ubuntu-jammy-systemd-docker:latest

ARG NEW_USER

RUN --mount=type=secret,id=newpass \
    useradd -m -d /home/${NEW_USER} -s /bin/bash -G sudo ${NEW_USER} \
    && echo "${NEW_USER}:$(cat /run/secrets/newpass)" | chpasswd \
    && usermod -aG docker ${NEW_USER} \
    && userdel -r admin

RUN mkdir -p /home/${NEW_USER}/.ssh \
    && chown ${NEW_USER}:${NEW_USER} /home/${NEW_USER}/.ssh

RUN apt-get update && apt-get install -y \
    iputils-ping \
    net-tools \
    curl \
    wget \
    git \
    traceroute \
    dnsutils \
    iptables \
    vim \
    make \
    tree \
    gpg \
    coreutils \
    && rm -rf /var/lib/apt/lists/* && apt-get autoclean

# Provision Installation Scripts
COPY --chown=$NEW_USER:$NEW_USER --chmod=700 scripts/* /home/${NEW_USER}/supply_scripts/
