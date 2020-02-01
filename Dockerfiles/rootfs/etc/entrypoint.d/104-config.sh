#!/usr/bin/env bash

# shellcheck disable=SC1091
# shellcheck disable=SC2086

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Create conf.d directory
mkdir -p "$MARIADB_CONFIG_DIR/conf.d/"
chown -R $MARIADB_USER:$MARIADB_GROUP "$MARIADB_CONFIG_DIR"

# Create default config if config directory is empty
if [ "$(find ${MARIADB_CONFIG_DIR}/* -type f -maxdepth 0 | wc -m)" == "0" ]; then


    # Use templater to generate mariadb.cnf
    DEBUG "Generating $MARIADB_CONFIG_DIR/mariadb.cnf"
    (set -a && source /etc/environment && templater /etc/entrypoint.d/templates/mariadb.cnf.tpl > $MARIADB_CONFIG_DIR/mariadb.cnf)

fi

# Functions used to compare verions
version_gt() { test "$(echo "$@" | tr " " "\n" | sort -g | head -n 1)" != "$1"; }
version_le() { test "$(echo "$@" | tr " " "\n" | sort -g | head -n 1)" == "$1"; }
version_lt() { test "$(echo "$@" | tr " " "\n" | sort -gr | head -n 1)" != "$1"; }
version_ge() { test "$(echo "$@" | tr " " "\n" | sort -gr | head -n 1)" == "$1"; }

# Comment deprecated
if version_ge "${MARIADB_MAJOR}" "10.2"; then
    if [ -f "$MARIADB_CONFIG_DIR/mariadb.cnf" ]; then
        sed -i '/^innodb_empty_free_list_algorithm/s//#&/' $MARIADB_CONFIG_DIR/mariadb.cnf
        sed -i '/^innodb_large_prefix/s//#&/' $MARIADB_CONFIG_DIR/mariadb.cnf
        sed -i '/^innodb_file_format/s//#&/' $MARIADB_CONFIG_DIR/mariadb.cnf
    fi
fi

# Update permissions
chown -R $MARIADB_USER:$MARIADB_GROUP "$MARIADB_CONFIG_DIR"
