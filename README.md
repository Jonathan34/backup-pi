# backup-pi

Simple backup script using rsync for raspberry pi.
- takes a list on input folders
- applies a list of exclude patterns
- sync everything to the destination folder (a mount in this case)
- also backups the crontab ran as pi user
