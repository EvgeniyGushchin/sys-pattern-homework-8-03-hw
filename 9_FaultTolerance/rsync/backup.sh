#!/bin/bash

SERVER=192.168.64.16
USER="$(whoami)"

SOURCE_DIR="${HOME}"
BACKUP_DIR="/tmp/backups"
DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
LATEST_LINK="${BACKUP_DIR}/latest"

ssh ${USER}@${SERVER} "mkdir -p ${BACKUP_PATH}"


rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  --exclude=".cache" \
  "${USER}@${SERVER}:${BACKUP_PATH}"

ssh ${USER}@${SERVER} "rm -rf ${LATEST_LINK}"
ssh ${USER}@${SERVER} "ln -s ${BACKUP_PATH} ${LATEST_LINK}"

readarray -t myArr < <(ssh ${USER}@${SERVER} "for i in ${BACKUP_DIR}/*/ ; do echo \${i}; done")

if [ ${#myArr[@]} -gt 6 ]
then
        ssh ${USER}@${SERVER} "rm -rf ${myArr[0]}"
fi