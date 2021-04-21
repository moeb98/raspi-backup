#!/bin/bash

# variables
BACKUP_PATH="/mnt/nas/raspi-backup"
BACKUP_REVISIONS="5"
BACKUP_NAME="raspi-backup"
DO_MOUNT=false;

# read command line arguments
while getopts n:r:p:m: flag
do
    case "${flag}" in
        n) BACKUP_NAME=${OPTARG};;
        r) BACKUP_REVISIONS=${OPTARG};;
        p) BACKUP_PATH=${OPTARG};;
	m) DO_MOUNT=${OPTARG};;
    esac
done

if [ $DO_MOUNT == true ]; then
    # mount hard drive in case that is required
    echo "Mounting ..."
    mount -t cifs -o credentials=/etc/smbcredentials,rw,file_mode=0777,dir_mode=0777 //192.168.1.2/Public /mnt/nas
fi

# perform backup
dd if=/dev/mmcblk0 of=${BACKUP_PATH}/${BACKUP_NAME}-$(date +%Y%m%d).img bs=1MB

# delete old backups and keep BACKUP_NUMBER of backups only
pushd ${BACKUP_PATH}; ls -tr ${BACKUP_PATH}/${BACKUP_NAME}* | head -n -${BACKUP_REVISIONS} | xargs rm; popd

if [ $DO_MOUNT == true ]; then
    echo "Unmounting ... "
    # unmount hard drive in case that is required
    umount /mnt/nas
fi
