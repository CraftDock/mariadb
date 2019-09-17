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

    # Define default variables to be used in the config file
    export MYSQL_BIND_ADRESS=${MYSQL_BIND_ADRESS:='0.0.0.0'}
    export MYSQL_BINLOG_FORMAT=${MYSQL_BINLOG_FORMAT:='mixed'}
    export MYSQL_CHARACTER_SET_SERVER=${MYSQL_CHARACTER_SET_SERVER:='utf8'}
    export MYSQL_CLIENT_DEFAULT_CHARACTER_SET=${MYSQL_CLIENT_DEFAULT_CHARACTER_SET:='utf8'}
    export MYSQL_COLLATION_SERVER=${MYSQL_COLLATION_SERVER:='utf8_unicode_ci'}
    export MYSQL_DUMP_MAX_ALLOWED_PACKET=${MYSQL_DUMP_MAX_ALLOWED_PACKET:='16M'}
    export MYSQL_GENERAL_LOG=${MYSQL_GENERAL_LOG:='0'}
    export MYSQL_INNODB_BUFFER_POOL_SIZE=${MYSQL_INNODB_BUFFER_POOL_SIZE:='16M'}
    export MYSQL_INNODB_DATA_FILE_PATH=${MYSQL_INNODB_DATA_FILE_PATH:='ibdata1:10M:autoextend:max:10G'}
    export MYSQL_INNODB_DEFAULT_ROW_FORMAT=${MYSQL_INNODB_DEFAULT_ROW_FORMAT:='dynamic'}
    export MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM=${MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM:='legacy'}
    export MYSQL_INNODB_FILE_FORMAT=${MYSQL_INNODB_FILE_FORMAT:='Antelope'}
    export MYSQL_INNODB_FILE_PER_TABLE=${MYSQL_INNODB_FILE_PER_TABLE:='ON'}
    export MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT=${MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT:='1'}
    export MYSQL_INNODB_LARGE_PREFIX=${MYSQL_INNODB_LARGE_PREFIX:='OFF'}
    export MYSQL_INNODB_LOCK_WAIT_TIMEOUT=${MYSQL_INNODB_LOCK_WAIT_TIMEOUT:='50'}
    export MYSQL_INNODB_LOG_BUFFER_SIZE=${MYSQL_INNODB_LOG_BUFFER_SIZE:='8M'}
    export MYSQL_INNODB_LOG_FILE_SIZE=${MYSQL_INNODB_LOG_FILE_SIZE:='5M'}
    export MYSQL_INNODB_USE_NATIVE_AIO=${MYSQL_INNODB_USE_NATIVE_AIO:='1'}
    export MYSQL_KEY_BUFFER_SIZE=${MYSQL_KEY_BUFFER_SIZE:='16M'}
    export MYSQL_LOG_BIN=${MYSQL_LOG_BIN:='mysql-bin'}
    export MYSQL_LOG_DIR=${MYSQL_LOG_DIR:=${MARIADB_LOG_DIR:='/var/log/mariadb'}}
    export MYSQL_MAX_ALLOWED_PACKET=${MYSQL_MAX_ALLOWED_PACKET:='1M'}
    export MYSQL_MYISAM_SORT_BUFFER_SIZE=${MYSQL_MYISAM_SORT_BUFFER_SIZE:='8M'}
    export MYSQL_MYISAMCHK_KEY_BUFFER_SIZE=${MYSQL_MYISAMCHK_KEY_BUFFER_SIZE:='20M'}
    export MYSQL_MYISAMCHK_READ_BUFFER=${MYSQL_MYISAMCHK_READ_BUFFER:='2M'}
    export MYSQL_MYISAMCHK_SORT_BUFFER_SIZE=${MYSQL_MYISAMCHK_SORT_BUFFER_SIZE:='20M'}
    export MYSQL_MYISAMCHK_WRITE_BUFFER=${MYSQL_MYISAMCHK_WRITE_BUFFER:='2M'}
    export MYSQL_NET_BUFFER_LENGTH=${MYSQL_NET_BUFFER_LENGTH:='8K'}
    export MYSQL_OPTIMIZER_PRUNE_LEVEL=${MYSQL_OPTIMIZER_PRUNE_LEVEL:='1'}
    export MYSQL_OPTIMIZER_SEARCH_DEPTH=${MYSQL_OPTIMIZER_SEARCH_DEPTH:='62'}
    export MYSQL_READ_BUFFER_SIZE=${MYSQL_READ_BUFFER_SIZE:='256K'}
    export MYSQL_READ_RND_BUFFER_SIZE=${MYSQL_READ_RND_BUFFER_SIZE:='512K'}
    export MYSQL_SERVER_ID=${MYSQL_SERVER_ID:='1'}
    export MYSQL_SLOW_QUERY_LOG=${MYSQL_SLOW_QUERY_LOG:='0'}
    export MYSQL_SORT_BUFFER_SIZE=${MYSQL_SORT_BUFFER_SIZE:='512K'}
    export MYSQL_TABLE_OPEN_CACHE=${MYSQL_TABLE_OPEN_CACHE:='64'}
    export MYSQL_TRANSACTION_ISOLATION=${MYSQL_TRANSACTION_ISOLATION:='READ-COMMITTED'}
    export TIMEZONE=${TIMEZONE:='+00:00'}

    # Functions used to compare verions
    version_gt() { test "$(echo "$@" | tr " " "\n" | sort -g | head -n 1)" != "$1"; }
    version_le() { test "$(echo "$@" | tr " " "\n" | sort -g | head -n 1)" == "$1"; }
    version_lt() { test "$(echo "$@" | tr " " "\n" | sort -gr | head -n 1)" != "$1"; }
    version_ge() { test "$(echo "$@" | tr " " "\n" | sort -gr | head -n 1)" == "$1"; }

    # Use templater to generate mariadb.cnf
    DEBUG "Generating $MARIADB_CONFIG_DIR/mariadb.cnf"
    (export > /tmp/env && set -a && source /tmp/env && templater /etc/entrypoint.d/templates/mariadb.cnf.tpl > $MARIADB_CONFIG_DIR/mariadb.cnf)

    # Comment deprecated
    if version_ge "${MARIADB_MAJOR}" "10.2"; then
        if [ -f "$MARIADB_CONFIG_DIR/mariadb.cnf" ]; then
            sed -i '/^innodb_empty_free_list_algorithm/s//#&/' $MARIADB_CONFIG_DIR/mariadb.cnf
            sed -i '/^innodb_large_prefix/s//#&/' $MARIADB_CONFIG_DIR/mariadb.cnf
            sed -i '/^innodb_file_format/s//#&/' $MARIADB_CONFIG_DIR/mariadb.cnf
        fi
    fi
fi

# Update permissions
chown -R $MARIADB_USER:$MARIADB_GROUP "$MARIADB_CONFIG_DIR"
