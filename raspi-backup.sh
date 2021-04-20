#!/bin/bash

# mount hard drive in case that is required
mount -t cifs -o credentials=/etc/smbcredentials,rw,file_mode=0777,dir_mode=0777 //192.168.1.2/Public /mnt/nas

# variables
BACKUP_PATH="/mnt/nas/raspi-backup"
BACKUP_NUMBER="5"
BACKUP_NAME="raspi-backup"

# perform backup
dd if=/dev/mmcblk0 of=${BACKUP_PATH}/${BACKUP_NAME}-$(date +%Y%m%d).img bs=1MB

# delete old backups and keep BACKUP_NUMBER of backups only
pushd ${BACKUP_PATH}; ls -tr ${BACKUP_PATH}/${BACKUP_NAME}* | head -n -${BACKUP_NUMBER} | xargs rm; popd

# unmount hard drive in case that is required
umount /mnt/nas
