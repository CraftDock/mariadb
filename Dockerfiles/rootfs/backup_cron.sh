#!/bin/bash
set -eu

# Wait for MariaDb server connection
dockerize -wait tcp://${BACKUP_MYSQL_HOST}:${BACKUP_MYSQL_PORT} -timeout ${BACKUP_TIMEOUT}

# Create log file
touch /var/log/mysql/backup.log
chmod 640 /var/log/mysql/backup.log
chown mysql:mysql /var/log/mysql/backup.log

# Update backup folder permissions
chown -R mysql:mysql /backup

# Create cron job
mkdir -p /var/spool/cron/crontabs
echo "${BACKUP_CRON_TIME} bash /backup.sh >> /var/log/mysql/backup.log 2>&1" > /var/spool/cron/crontabs/mysql

echo "=> Running cron task manager"
exec busybox crond -f -l 8 -L /dev/stdout
