FROM nestybox/ubuntu-jammy-systemd-docker:latest

ARG NEW_USER
ARG USE_SSH_PASSWD_AUTH=yes

RUN --mount=type=secret,id=newpass \
    useradd -m -d /home/${NEW_USER} -s /bin/bash -G sudo ${NEW_USER} \
    && echo "${NEW_USER}:$(cat /run/secrets/newpass)" | chpasswd \
    && usermod -aG docker ${NEW_USER} \
    && userdel -r admin \
    && echo "$NEW_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$NEW_USER

RUN mkdir -p /home/${NEW_USER}/.ssh \
    && ssh-keygen -t rsa -b 4096 -f "/home/$NEW_USER/.ssh/id_rsa" -C "$NEW_USER" -N "" \
    && cp "/home/$NEW_USER/.ssh/id_rsa.pub" "/home/$NEW_USER/.ssh/authorized_keys" \
    && chown -R ${NEW_USER}:${NEW_USER} /home/${NEW_USER}/.ssh \
    && echo "PasswordAuthentication ${USE_SSH_PASSWD_AUTH}" >> /etc/ssh/sshd_config \
    && echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

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
