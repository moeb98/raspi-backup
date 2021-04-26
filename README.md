# raspi-backup

Create an image of the Raspi SD card during runtime and without removing the card.

## Usage

The script backs up images of the Raspi SD card to a given path and keeps a number
of revisions of those backups. The path can be a e.g. a NAS filer that is either
mounted already or that can be mounted by the script (depending on the ```-m```
flag). The images are stored under the given path (which can be given with the
```-p``` flag) and given name (which can be given with the ```-n``` flag) that
is supplemented by the timestamp. The script keeps the number of revisions given
by the ```-r``` flag and delete older ones.

## Installation

The script can be called directly via the command line, but for regular backups
should be 'installed' as a cronjob:

```bash
sudo crontab -e
```

## Flags

The script can be called with various flags configuring its behaviour. Namely these
are:

* ```-p``` defines the path to the backup folder, defaults to
  ```/mnt/nas/raspi-backup```
* ```-n``` defines the name of the backup file (automatically supplemented by the
  timestamp, defaults to ```raspi-backup```
* ```-r``` defines the number revisions to be kept as backup, defaults to ```5```
* ```-m``` defines whether the backup folder path needs to be mounted first,
  defaults to ```false```
