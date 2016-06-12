#!/bin/bash

#Destination folder
DEST=/media/seagate3tb/backups/rsync/`date +%Y-%m-%d`

#Exclude patterns
EXCLUDE={"/var/cache","/var/tmp","*tmp*","*.bak","temp"}

#rsync options
RSYNC_OPTIONS=-aAXhvR

#inputs folders
INPUTS=(
	#transmission
	'/home/pi/.config/transmission-daemon'
	#couchpotato
	'/opt/couchpotato/*.conf'
	'/opt/couchpotato/db_backup/*.tar.gz'
	#sickrage
	'/opt/sickrage/config.ini'
	'/opt/sickrage/backup/sickrage*.zip'
	#openvpn
	'/etc/openvpn/*'
	#ssh
	'/home/pi/.ssh/*'
	'/etc/ssh/*'
	#various
	'/opt/speedtest-cli-extras/*'
	#kodi
	#'/home/pi/.kodi/*'
	#nzbget
	'/opt/nzbget/*.conf'
	'/opt/nzbget/scripts/*'
	#general
	'/etc/default/*'
	'/etc/resolv.conf'
	'/etc/exports'
	'/etc/fstab'
	#bash
	'/home/pi/.bash_aliases'
	'/home/pi/.bashrc'
	'/etc/*.conf'
	'/etc/network/interfaces'
)

#create paths
mkdir -p $DEST

#sync 
for file in "${INPUTS[@]}" 
do
	echo "$file"
	rsync $RSYNC_OPTIONS --exclude=$EXCLUDE $file $DEST
done

#backup crontab as user pi
sudo -u pi crontab -l > $DEST/crontab.bckp
#restore with crontab file.bckp
