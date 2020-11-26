FROM alpine:3.11

LABEL "com.github.actions.name" = "Ansible Playbook Runner"
LABEL "com.github.actions.description" = "Runs ansible playbooks"
LABEL "com.github.actions.icon" = "activity"
LABEL "com.github.actions.color" = "white"
LABEL "repository" = "https://github.com/ambimax/ansible-playbook-runner"
LABEL "homepage" = "https://github.com/ambimax/ansible-playbook-runner"

RUN apk add bash curl openssh-client gcc python3-dev libc-dev libffi-dev openssl-dev git &&\
    apk add --no-cache --update python3
RUN pip3 install --upgrade ansible

COPY entrypoint.sh /entrypoint.sh

RUN mkdir -p /root/.ssh; \
    echo "" > /root/.ssh/known_hosts; \
    echo "" > /root/.ssh/id_rsa; \
    chmod 600 /root/.ssh/id_rsa; \
    chmod +x /entrypoint.sh;

WORKDIR /opt

ENV ANSIBLE_HOST_KEY_CHECKING false
ENV SSH_KEY false
ENV HOSTS_FILE hosts.ini
ENV PLAYBOOK_FILE playbook.yml
ENV REQUIRED_ROLES_FILE required-roles.yml
ENV KNOWN_HOSTS_FILE known_hosts

RUN ansible-galaxy collection install amazon.aws

ENTRYPOINT ["/entrypoint.sh"]
