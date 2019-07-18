#!/usr/bin/env bash

# Update permissions
find /mysql/conf/ \( \! -user mysql -o \! -group mysql \) -print0 | xargs -0 -r chown mysql:mysql
find /mysql/db/ \( \! -user mysql -o \! -group mysql \) -print0 | xargs -0 -r chown mysql:mysql
find ${MYSQL_BACKUP_DIR} \( \! -user mysql -o \! -group mysql \) -print0 | xargs -0 -r chown mysql:mysql
find ${MYSQL_LOG_DIR} \( \! -user mysql -o \! -group mysql \) -print0 | xargs -0 -r chown mysql:mysql
