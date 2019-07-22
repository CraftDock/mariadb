#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/persist-env.sh

# Mariadb version
env_set "MARIADB_MAJOR"   "$(env_get "MARIADB_MAJOR")"
env_set "MARIADB_VERSION" "$(env_get "MARIADB_VERSION")"

# Environment variables used by services
[ -n "$(env_get "MYSQL_ALLOW_EMPTY_PASSWORD")" ]    && env_set "MYSQL_ALLOW_EMPTY_PASSWORD" "$(env_get "MYSQL_ALLOW_EMPTY_PASSWORD")"
[ -n "$(env_get "MYSQL_BACKUP_COUNT")" ]            && env_set "MYSQL_BACKUP_COUNT" "$(env_get "MYSQL_BACKUP_COUNT")"
[ -n "$(env_get "MYSQL_BACKUP_DIR")" ]              && env_set "MYSQL_BACKUP_DIR" "$(env_get "MYSQL_BACKUP_DIR")"
[ -n "$(env_get "MYSQL_DATA_DIR")" ]                && env_set "MYSQL_DATA_DIR" "$(env_get "MYSQL_DATA_DIR")"
[ -n "$(env_get "MYSQL_DATABASE")" ]                && env_set "MYSQL_DATABASE" "$(env_get "MYSQL_DATABASE")"
[ -n "$(env_get "MYSQL_INSTALL_PARAMS")" ]          && env_set "MYSQL_INSTALL_PARAMS" "$(env_get "MYSQL_INSTALL_PARAMS")"
[ -n "$(env_get "MYSQL_PASSWORD")" ]                && env_set "MYSQL_PASSWORD" "$(env_get "MYSQL_PASSWORD")"
[ -n "$(env_get "MYSQL_RANDOM_ROOT_PASSWORD")" ]    && env_set "MYSQL_RANDOM_ROOT_PASSWORD" "$(env_get "MYSQL_RANDOM_ROOT_PASSWORD")"
[ -n "$(env_get "MYSQL_ROOT_PASSWORD")" ]           && env_set "MYSQL_ROOT_PASSWORD" "$(env_get "MYSQL_ROOT_PASSWORD")"
[ -n "$(env_get "MYSQL_STARTCMD")" ]                && env_set "MYSQL_STARTCMD" "$(env_get "MYSQL_STARTCMD")"
[ -n "$(env_get "MYSQL_STARTPARAMS")" ]             && env_set "MYSQL_STARTPARAMS" "$(env_get "MYSQL_STARTPARAMS")"
[ -n "$(env_get "MYSQL_USER")" ]                    && env_set "MYSQL_USER" "$(env_get "MYSQL_USER")"
[ -n "$(env_get "TIMEZONE")" ]                      && env_set "TIMEZONE" "$(env_get "TIMEZONE")"
