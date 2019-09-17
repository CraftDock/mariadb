#!/usr/bin/env bash

# shellcheck disable=SC2015

# Mariadb variables
env_set "MARIADB_MAJOR"      "$(env_get "MARIADB_MAJOR")"
env_set "MARIADB_VERSION"    "$(env_get "MARIADB_VERSION")"
env_set "MARIADB_DATA_DIR"   "$(env_get "MARIADB_DATA_DIR" "$(env_get "MYSQL_DATA_DIR")")"
env_set "MARIADB_CONFIG_DIR" "$(env_get "MARIADB_CONFIG_DIR" "$(env_get "MYSQL_CONFIG_DIR")")"
env_set "MARIADB_BACKUP_DIR" "$(env_get "MARIADB_BACKUP_DIR" "$(env_get "MYSQL_BACKUP_DIR")")"
env_set "MARIADB_LOG_DIR"    "$(env_get "MARIADB_LOG_DIR" "$(env_get "MYSQL_LOG_DIR")")"
env_set "MARIADB_USER"       "$(env_get "MARIADB_USER")"
env_set "MARIADB_GROUP"      "$(env_get "MARIADB_GROUP")"

# Environment variables used by mariadb service
[ -n "$(env_get "MYSQL_ALLOW_EMPTY_PASSWORD")" ]    && env_set "MYSQL_ALLOW_EMPTY_PASSWORD" "$(env_get "MYSQL_ALLOW_EMPTY_PASSWORD")" || true
[ -n "$(env_get "MYSQL_BACKUP_COUNT")" ]            && env_set "MYSQL_BACKUP_COUNT" "$(env_get "MYSQL_BACKUP_COUNT")" || true
[ -n "$(env_get "MYSQL_BACKUP_DIR")" ]              && env_set "MYSQL_BACKUP_DIR" "$(env_get "MYSQL_BACKUP_DIR")" || true
[ -n "$(env_get "MYSQL_DATA_DIR")" ]                && env_set "MYSQL_DATA_DIR" "$(env_get "MYSQL_DATA_DIR")" || true
[ -n "$(env_get "MYSQL_DATABASE")" ]                && env_set "MYSQL_DATABASE" "$(env_get "MYSQL_DATABASE")" || true
[ -n "$(env_get "MYSQL_INSTALL_PARAMS")" ]          && env_set "MYSQL_INSTALL_PARAMS" "$(env_get "MYSQL_INSTALL_PARAMS")" || true
[ -n "$(env_get "MYSQL_PASSWORD")" ]                && env_set "MYSQL_PASSWORD" "$(env_get "MYSQL_PASSWORD")" || true
[ -n "$(env_get "MYSQL_RANDOM_ROOT_PASSWORD")" ]    && env_set "MYSQL_RANDOM_ROOT_PASSWORD" "$(env_get "MYSQL_RANDOM_ROOT_PASSWORD")" || true
[ -n "$(env_get "MYSQL_ROOT_PASSWORD")" ]           && env_set "MYSQL_ROOT_PASSWORD" "$(env_get "MYSQL_ROOT_PASSWORD")" || true
[ -n "$(env_get "MYSQL_STARTCMD")" ]                && env_set "MYSQL_STARTCMD" "$(env_get "MYSQL_STARTCMD")" || true
[ -n "$(env_get "MYSQL_STARTPARAMS")" ]             && env_set "MYSQL_STARTPARAMS" "$(env_get "MYSQL_STARTPARAMS")" || true
[ -n "$(env_get "MYSQL_USER")" ]                    && env_set "MYSQL_USER" "$(env_get "MYSQL_USER")" || true
[ -n "$(env_get "TIMEZONE")" ]                      && env_set "TIMEZONE" "$(env_get "TIMEZONE")" || true

# Environnement variables which must exist
[ -z "$(env_get "MYSQL_DATA_DIR")" ]                && env_set "MYSQL_DATA_DIR" "$(env_get "MARIADB_DATA_DIR")" || true
[ -z "$(env_get "MYSQL_CONFIG_DIR")" ]              && env_set "MYSQL_CONFIG_DIR" "$(env_get "MARIADB_CONFIG_DIR")" || true
[ -z "$(env_get "MYSQL_BACKUP_DIR")" ]              && env_set "MYSQL_BACKUP_DIR" "$(env_get "MARIADB_BACKUP_DIR")" || true
[ -z "$(env_get "MYSQL_LOG_DIR")" ]                 && env_set "MYSQL_LOG_DIR" "$(env_get "MARIADB_LOG_DIR")" || true
