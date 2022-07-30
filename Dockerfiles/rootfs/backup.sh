#!/bin/bash


[ -z "${MYSQL_USER}" ] && { echo "=> MYSQL_USER cannot be empty" && exit 1; }
# If provided, take password from file
[ -z "${MYSQL_PASS_FILE}" ] || { MYSQL_PASS=$(head -1 "${MYSQL_PASS_FILE}"); }
# Alternatively, take it from env var
[ -z "${MYSQL_PASS:=$MYSQL_PASSWORD}" ] && { echo "=> MYSQL_PASSWORD cannot be empty" && exit 1; }
[ -z "${BACKUP_GZIP_LEVEL}" ] && { BACKUP_GZIP_LEVEL=6; }

# date format
DATE=$(date +"%Y%m%d%H%M")

echo "=> Backup started at $(date "+%Y-%m-%d %H:%M:%S")"
DATABASES=${BACKUP_DATABASE:-${BACKUP_DB:-$(mysql -h "$BACKUP_MYSQL_HOST" -P "$BACKUP_MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" $MYSQL_SSL_OPTS -e "SHOW DATABASES;" | tr -d "| " | grep -v Database)}}

for db in ${DATABASES}
do
  if  [[ "$db" != "information_schema" ]] \
      && [[ "$db" != "performance_schema" ]] \
      && [[ "$db" != "mysql" ]] \
      && [[ "$db" != "sys" ]] \
      && [[ "$db" != _* ]]
  then
    echo "==> Dumping database: $db"
    FILENAME=/backup/$DATE.$db.sql
    LATEST=/backup/latest.$db.sql
    if mysqldump --single-transaction $BACKUP_DUMP_OPTS -h "$BACKUP_MYSQL_HOST" -P "$BACKUP_MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" $MYSQL_SSL_OPTS "$db" > "$FILENAME"
    then
      EXT=
      if [ -z "${BACKUP_USE_PLAIN_SQL}" ]
      then
        echo "==> Compressing $db with LEVEL $BACKUP_GZIP_LEVEL"
        gzip "-$BACKUP_GZIP_LEVEL" -f "$FILENAME"
        EXT=.gz
        FILENAME=$FILENAME$EXT
        LATEST=$LATEST$EXT
      fi
      BASENAME=$(basename "$FILENAME")

      echo "==> Creating symlink to latest backup: $BASENAME"
      rm "$LATEST" 2> /dev/null
      cd /backup || exit && ln -s "$BASENAME" "$(basename "$LATEST")"

      if [ -n "$BACKUP_RETENTION_DAYS" ]
      then
        while [ "$(find /backup -maxdepth 1 -name "*.$db.sql$EXT" -type f -mtime "+${BACKUP_RETENTION_DAYS}" | wc -l)" -gt 0 ]
        do
          TARGET=$(find /backup -maxdepth 1 -name "*.$db.sql$EXT" -type f -mtime "+${BACKUP_RETENTION_DAYS}" | sort | head -n 1)
          echo "==> Retention period of ${BACKUP_RETENTION_DAYS} days reached. Deleting ${TARGET} ..."
          rm -rf "${TARGET}"
          echo "==> Backup ${TARGET} deleted"
        done
      fi

      if [ -n "$BACKUP_MAX_BACKUPS" ]
      then
        while [ "$(find /backup -maxdepth 1 -name "*.$db.sql$EXT" -type f | wc -l)" -gt "$BACKUP_MAX_BACKUPS" ]
        do
          TARGET=$(find /backup -maxdepth 1 -name "*.$db.sql$EXT" -type f | sort | head -n 1)
          echo "==> Max number of ($BACKUP_MAX_BACKUPS) backups reached. Deleting ${TARGET} ..."
          rm -rf "${TARGET}"
          echo "==> Backup ${TARGET} deleted"
        done
      fi

    else
      rm -rf "$FILENAME"
    fi
  fi
done
echo "=> Backup process finished at $(date "+%Y-%m-%d %H:%M:%S")"
