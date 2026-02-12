# Use Ubuntu as the base image
FROM ubuntu:latest

LABEL maintainer="Saw Nay Thar Poe <sawnaytharhpoe02@gmail.com>"
LABEL description="This is a Dockerfile to use as a control node for Ansible."

# Update and install Ansible
RUN apt-get update && \
    apt-get install -y ansible vim sudo curl && \
    apt-get clean

# Add the new user and set bash as the default shell for the user, set the home directory, add the user to the sudo group
# RUN useradd -m -s /bin/bash ubuntu && \
RUN usermod -aG sudo ubuntu && \
    mkdir -p /home/ubuntu/.ssh && \
    chown -R ubuntu:ubuntu /home/ubuntu/ && \
    chmod 700 /home/ubuntu/.ssh && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /home/ubuntu/playbooks && \
    chown -R ubuntu:ubuntu /home/ubuntu/playbooks

WORKDIR /home/ubuntu