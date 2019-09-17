#!/usr/bin/env bash

# shellcheck disable=SC2086

# Create folders
mkdir -p "$MARIADB_DATA_DIR"
mkdir -p "$MARIADB_CONFIG_DIR/conf.d"
mkdir -p "$MARIADB_BACKUP_DIR"
mkdir -p "$MARIADB_LOG_DIR"
mkdir -p /usr/lib/mysql/plugin
mkdir -p /var/run/mariadb

# Adjust owner per folder
update_owner() {
    find "$1" \( \! -user $2 -o \! -group $3 \) -print0 | xargs -0 -r chown $2:$3
    chown -R $2:$3 "$1"
}
update_owner $MARIADB_DATA_DIR          $MARIADB_USER $MARIADB_GROUP
update_owner $MARIADB_CONFIG_DIR        $MARIADB_USER $MARIADB_GROUP
update_owner $MARIADB_BACKUP_DIR        $MARIADB_USER $MARIADB_GROUP
update_owner $MARIADB_LOG_DIR           $MARIADB_USER $MARIADB_GROUP
update_owner /usr/lib/mysql/plugin      $MARIADB_USER $MARIADB_GROUP
update_owner /var/run/mariadb           $MARIADB_USER $MARIADB_GROUP

# Keep mysql compatibility
if [ ! -d "/var/lib/mysql" ] && [ ! -L "/var/lib/mysql" ]; then
    ln -s "${MARIADB_DATA_DIR}" /var/lib/mysql
fi
if [ ! -d "/etc/mysql" ] && [ ! -L "/etc/mysql" ]; then
    ln -s "${MARIADB_CONFIG_DIR}" /etc/mysql
fi
