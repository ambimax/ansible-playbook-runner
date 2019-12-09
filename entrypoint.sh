#!/bin/sh

function error_exit {
    echo $1
    exit 1;
}

pwd

if [ ! -f "${HOSTS_FILE}" ]; then error_exit "hosts file not found"; fi;
if [ ! -f "${PLAYBOOK_FILE}" ]; then error_exit "playbook file not found"; fi;

if [ -f "${KNOWN_HOSTS_FILE}" ]; then
    cp ${KNOWN_HOSTS_FILE} /root/.ssh/known_hosts;
fi;

if [ -z "${SSH_KEY}" ]; then
    echo ${SSH_KEY} > /root/.ssh/id_rsa;
fi;

ls -lah /root/.ssh
cat /root/.ssh/id_rsa
cat /root/.ssh/known_hosts

if [ -f "${REQUIRED_ROLES_FILE}" ]; then
    ansible-galaxy install -r ${REQUIRED_ROLES_FILE} -p roles;
fi;


ansible-playbook -i ${HOSTS_FILE} ${PLAYBOOK_FILE}
