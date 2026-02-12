FROM nginx:alpine

LABEL maintainer="Saw Nay Thar Poe <sawnaytharhpoe02@gmail.com>"
LABEL description="This is a Dockerfile to use as web server node for Ansible."

# Overwrite default welcome page
RUN echo "Hello, this is a web server node for Ansible." > /usr/share/nginx/html/index.html

# Install openssh-server
RUN apk update && \
    apk add openssh-server python3 && \
    rm -rf /var/cache/apk/*

# CREATE SSH DIRECTORY for root user
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    ssh-keygen -A
    

# Run sshd and nginx in the foreground parallel
CMD ["sh", "-c", "/usr/sbin/sshd && nginx -g 'daemon off;'"]