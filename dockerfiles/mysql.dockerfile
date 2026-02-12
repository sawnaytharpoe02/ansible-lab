FROM mysql:latest

LABEL maintainer="Saw Nay Thar Poe <sawnaytharhpoe02@gmail.com>"
LABEL description="This is a Dockerfile to use as database server node for Ansible."

# Install openssh-server on orcalelinux
RUN microdnf install -y openssh-server python3 

# CREATE SSH DIRECTORY for root user
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    ssh-keygen -A && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#StrictModes.*/StrictModes no/' /etc/ssh/sshd_config && \
    echo "StrictModes no" >> /etc/ssh/sshd_config

# Create startup script to run sshd and then the standard entrypoint
RUN echo '#!/bin/bash' > /start.sh && \
    echo '/usr/sbin/sshd' >> /start.sh && \
    echo 'exec /usr/local/bin/docker-entrypoint.sh mysqld' >> /start.sh && \
    chmod +x /start.sh

CMD ["/start.sh"]