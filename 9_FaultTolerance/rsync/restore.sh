#!/bin/bash

SERVER=192.168.64.16
USER="$(whoami)"
BACKUP_DIR="/tmp/backups"

if [[ $1 = "latest" ]]
then
        # restore latest
        rsync -av --delete "${USER}@${SERVER}:${BACKUP_DIR}/latest/" "/home/${USER}"
        exit
fi


readarray -t BACKUP_LIST < <(ssh ${USER}@${SERVER} "for i in ${BACKUP_DIR}/*/ ; do echo \${i}; done")

echo "Available backups:"
for i in "${!BACKUP_LIST[@]}";
do
    echo "$i -> ${BACKUP_LIST[$i]}"
done

read -p 'Select backup number or enter any other symbol to exit: ' selection

regExp='^[0-9]+$'

if ! [[ $selection =~ $regExp ]] ; then
   exit
elif [[ $selection -lt ${#BACKUP_LIST[@]} ]]; then
        rsync -av --delete "${USER}@${SERVER}:${BACKUP_LIST[$selection]}/" "/home/${USER}"
fi