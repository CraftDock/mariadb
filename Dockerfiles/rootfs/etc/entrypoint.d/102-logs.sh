#!/usr/bin/env bash

# shellcheck disable=SC2086

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Create general log folder if necessary
if [ "$(env_get "MYSQL_GENERAL_LOG")" = "1" ]; then
    DEBUG "general log enable"
    if [[ ! -d "${MYSQL_LOG_DIR}" ]]; then
        DEBUG "Creating general log folder: ${MYSQL_LOG_DIR}"
        mkdir -p ${MYSQL_LOG_DIR}
    fi
    if [ -d "${MYSQL_LOG_DIR}" ] && [ ! -f "${MYSQL_LOG_DIR}/mysql.log" ]; then
        DEBUG "Creating mariadb general log file: ${MYSQL_LOG_DIR}/mysql.log"
        touch ${MYSQL_LOG_DIR}/mysql.log
    fi
fi

# Create slow query log folder if necessary
if [ "$(env_get "MYSQL_SLOW_QUERY_LOG")" = "1" ]; then
    DEBUG "slow query log enable"
    if [[ ! -d "${MYSQL_LOG_DIR}" ]]; then
        DEBUG "Creating slow query log folder: ${MYSQL_LOG_DIR}"
        mkdir -p ${MYSQL_LOG_DIR}
    fi
    if [ -d "${MYSQL_LOG_DIR}" ] && [ ! -f "${MYSQL_LOG_DIR}/mysql-slow.log" ]; then
        DEBUG "Creating mariadb slow query log file: ${MYSQL_LOG_DIR}/mysql-slow.log"
        touch ${MYSQL_LOG_DIR}/mysql-slow.log
    fi
fi

# Update permissions
chown -R ${MARIADB_USER}:${MARIADB_GROUP} "${MYSQL_LOG_DIR}"
chmod 0775 "${MYSQL_LOG_DIR}"
