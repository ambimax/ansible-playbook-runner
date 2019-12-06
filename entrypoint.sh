#!/bin/sh

function error_exit {
    echo $1
    exit 1;
}

if [ ! -f "${HOSTS_FILE}" ]; then error_exit "hosts file not found"; fi;
if [ ! -f "${PLAYBOOK_FILE}" ]; then error_exit "playbook file not found"; fi;

if [ -f "${REQUIRED_ROLES_FILE}" ]; then
    ansible-galaxy install -r ${REQUIRED_ROLES_FILE} -p roles;
fi;

ansible-playbook -i ${HOSTS_FILE} ${PLAYBOOK_FILE}
