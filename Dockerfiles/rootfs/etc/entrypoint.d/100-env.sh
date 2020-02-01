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

#
[ -n "$(env_get "MYSQL_ROOT_PASSWORD")" ] && env_set "MYSQL_ROOT_PASSWORD" "$(env_get "MYSQL_ROOT_PASSWORD")" || true
[ -n "$(env_get "MYSQL_ALLOW_EMPTY_PASSWORD")" ] && env_set "MYSQL_ALLOW_EMPTY_PASSWORD" "$(env_get "MYSQL_ALLOW_EMPTY_PASSWORD")" || true
[ -n "$(env_get "MYSQL_BACKUP_COUNT")" ] && env_set "MYSQL_BACKUP_COUNT" "$(env_get "MYSQL_BACKUP_COUNT")" || true
[ -n "$(env_get "MYSQL_BACKUP_DIR")" ] && env_set "MYSQL_BACKUP_DIR" "$(env_get "MYSQL_BACKUP_DIR")" || true
[ -n "$(env_get "MYSQL_DATA_DIR")" ] && env_set "MYSQL_DATA_DIR" "$(env_get "MYSQL_DATA_DIR")" || true
[ -n "$(env_get "MYSQL_DATABASE")" ] && env_set "MYSQL_DATABASE" "$(env_get "MYSQL_DATABASE")" || true
[ -n "$(env_get "MYSQL_INSTALL_PARAMS")" ] && env_set "MYSQL_INSTALL_PARAMS" "$(env_get "MYSQL_INSTALL_PARAMS")" || true
[ -n "$(env_get "MYSQL_LOG_DIR")" ] && env_set "MYSQL_LOG_DIR" "$(env_get "MYSQL_LOG_DIR")" || true
[ -n "$(env_get "MYSQL_PASSWORD")" ] && env_set "MYSQL_PASSWORD" "$(env_get "MYSQL_PASSWORD")" || true
[ -n "$(env_get "MYSQL_RANDOM_ROOT_PASSWORD")" ] && env_set "MYSQL_RANDOM_ROOT_PASSWORD" "$(env_get "MYSQL_RANDOM_ROOT_PASSWORD")" || true
[ -n "$(env_get "MYSQL_STARTCMD")" ] && env_set "MYSQL_STARTCMD" "$(env_get "MYSQL_STARTCMD")" || true
[ -n "$(env_get "MYSQL_STARTPARAMS")" ] && env_set "MYSQL_STARTPARAMS" "$(env_get "MYSQL_STARTPARAMS")" || true
[ -n "$(env_get "MYSQL_USER")" ] && env_set "MYSQL_USER" "$(env_get "MYSQL_USER")" || true

# Environment variables used by mariadb service
[ -n "$(env_get "MYSQL_BACK_LOG")" ] && env_set "MYSQL_BACK_LOG" "$(env_get "MYSQL_BACK_LOG")" || true
[ -n "$(env_get "MYSQL_BIND_ADRESS")" ] && env_set "MYSQL_BIND_ADRESS" "$(env_get "MYSQL_BIND_ADRESS")" || true
[ -n "$(env_get "MYSQL_BINLOG_FORMAT")" ] && env_set "MYSQL_BINLOG_FORMAT" "$(env_get "MYSQL_BINLOG_FORMAT")" || true
[ -n "$(env_get "MYSQL_CHARACTER_SET_FILESYSTEM")" ] && env_set "MYSQL_CHARACTER_SET_FILESYSTEM" "$(env_get "MYSQL_CHARACTER_SET_FILESYSTEM")" || true
[ -n "$(env_get "MYSQL_CHARACTER_SET_SERVER")" ] && env_set "MYSQL_CHARACTER_SET_SERVER" "$(env_get "MYSQL_CHARACTER_SET_SERVER")" || true
[ -n "$(env_get "MYSQL_CLIENT_DEFAULT_CHARACTER_SET")" ] && env_set "MYSQL_CLIENT_DEFAULT_CHARACTER_SET" "$(env_get "MYSQL_CLIENT_DEFAULT_CHARACTER_SET")" || true
[ -n "$(env_get "MYSQL_COLLATION_SERVER")" ] && env_set "MYSQL_COLLATION_SERVER" "$(env_get "MYSQL_COLLATION_SERVER")" || true
[ -n "$(env_get "MYSQL_DEFAULT_STORAGE_ENGINE")" ] && env_set "MYSQL_DEFAULT_STORAGE_ENGINE" "$(env_get "MYSQL_DEFAULT_STORAGE_ENGINE")" || true
[ -n "$(env_get "MYSQL_DUMP_MAX_ALLOWED_PACKET")" ] && env_set "MYSQL_DUMP_MAX_ALLOWED_PACKET" "$(env_get "MYSQL_DUMP_MAX_ALLOWED_PACKET")" || true
[ -n "$(env_get "MYSQL_GENERAL_LOG")" ] && env_set "MYSQL_GENERAL_LOG" "$(env_get "MYSQL_GENERAL_LOG")" || true
[ -n "$(env_get "MYSQL_INIT_CONNECT")" ] && env_set "MYSQL_INIT_CONNECT" "$(env_get "MYSQL_INIT_CONNECT")" || true
[ -n "$(env_get "MYSQL_INNODB_BUFFER_POOL_INSTANCES")" ] && env_set "MYSQL_INNODB_BUFFER_POOL_INSTANCES" "$(env_get "MYSQL_INNODB_BUFFER_POOL_INSTANCES")" || true
[ -n "$(env_get "MYSQL_INNODB_BUFFER_POOL_SIZE")" ] && env_set "MYSQL_INNODB_BUFFER_POOL_SIZE" "$(env_get "MYSQL_INNODB_BUFFER_POOL_SIZE")" || true
[ -n "$(env_get "MYSQL_INNODB_DATA_FILE_PATH")" ] && env_set "MYSQL_INNODB_DATA_FILE_PATH" "$(env_get "MYSQL_INNODB_DATA_FILE_PATH")" || true
[ -n "$(env_get "MYSQL_INNODB_DEFAULT_ROW_FORMAT")" ] && env_set "MYSQL_INNODB_DEFAULT_ROW_FORMAT" "$(env_get "MYSQL_INNODB_DEFAULT_ROW_FORMAT")" || true
[ -n "$(env_get "MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM")" ] && env_set "MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM" "$(env_get "MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM")" || true
[ -n "$(env_get "MYSQL_INNODB_FAST_SHUTDOWN")" ] && env_set "MYSQL_INNODB_FAST_SHUTDOWN" "$(env_get "MYSQL_INNODB_FAST_SHUTDOWN")" || true
[ -n "$(env_get "MYSQL_INNODB_FILE_FORMAT")" ] && env_set "MYSQL_INNODB_FILE_FORMAT" "$(env_get "MYSQL_INNODB_FILE_FORMAT")" || true
[ -n "$(env_get "MYSQL_INNODB_FILE_PER_TABLE")" ] && env_set "MYSQL_INNODB_FILE_PER_TABLE" "$(env_get "MYSQL_INNODB_FILE_PER_TABLE")" || true
[ -n "$(env_get "MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT")" ] && env_set "MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT" "$(env_get "MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT")" || true
[ -n "$(env_get "MYSQL_INNODB_FLUSH_METHOD")" ] && env_set "MYSQL_INNODB_FLUSH_METHOD" "$(env_get "MYSQL_INNODB_FLUSH_METHOD")" || true
[ -n "$(env_get "MYSQL_INNODB_FORCE_LOAD_CORRUPTED")" ] && env_set "MYSQL_INNODB_FORCE_LOAD_CORRUPTED" "$(env_get "MYSQL_INNODB_FORCE_LOAD_CORRUPTED")" || true
[ -n "$(env_get "MYSQL_INNODB_FORCE_RECOVERY")" ] && env_set "MYSQL_INNODB_FORCE_RECOVERY" "$(env_get "MYSQL_INNODB_FORCE_RECOVERY")" || true
[ -n "$(env_get "MYSQL_INNODB_IO_CAPACITY")" ] && env_set "MYSQL_INNODB_IO_CAPACITY" "$(env_get "MYSQL_INNODB_IO_CAPACITY")" || true
[ -n "$(env_get "MYSQL_INNODB_LARGE_PREFIX")" ] && env_set "MYSQL_INNODB_LARGE_PREFIX" "$(env_get "MYSQL_INNODB_LARGE_PREFIX")" || true
[ -n "$(env_get "MYSQL_INNODB_LOCK_WAIT_TIMEOUT")" ] && env_set "MYSQL_INNODB_LOCK_WAIT_TIMEOUT" "$(env_get "MYSQL_INNODB_LOCK_WAIT_TIMEOUT")" || true
[ -n "$(env_get "MYSQL_INNODB_LOG_BUFFER_SIZE")" ] && env_set "MYSQL_INNODB_LOG_BUFFER_SIZE" "$(env_get "MYSQL_INNODB_LOG_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_INNODB_LOG_FILE_SIZE")" ] && env_set "MYSQL_INNODB_LOG_FILE_SIZE" "$(env_get "MYSQL_INNODB_LOG_FILE_SIZE")" || true
[ -n "$(env_get "MYSQL_INNODB_LOG_FILES_IN_GROUP")" ] && env_set "MYSQL_INNODB_LOG_FILES_IN_GROUP" "$(env_get "MYSQL_INNODB_LOG_FILES_IN_GROUP")" || true
[ -n "$(env_get "MYSQL_INNODB_OLD_BLOCKS_TIME")" ] && env_set "MYSQL_INNODB_OLD_BLOCKS_TIME" "$(env_get "MYSQL_INNODB_OLD_BLOCKS_TIME")" || true
[ -n "$(env_get "MYSQL_INNODB_OPEN_FILES")" ] && env_set "MYSQL_INNODB_OPEN_FILES" "$(env_get "MYSQL_INNODB_OPEN_FILES")" || true
[ -n "$(env_get "MYSQL_INNODB_PURGE_THREADS")" ] && env_set "MYSQL_INNODB_PURGE_THREADS" "$(env_get "MYSQL_INNODB_PURGE_THREADS")" || true
[ -n "$(env_get "MYSQL_INNODB_READ_IO_THREADS")" ] && env_set "MYSQL_INNODB_READ_IO_THREADS" "$(env_get "MYSQL_INNODB_READ_IO_THREADS")" || true
[ -n "$(env_get "MYSQL_INNODB_STATS_ON_METADATA")" ] && env_set "MYSQL_INNODB_STATS_ON_METADATA" "$(env_get "MYSQL_INNODB_STATS_ON_METADATA")" || true
[ -n "$(env_get "MYSQL_INNODB_STRICT_MODE")" ] && env_set "MYSQL_INNODB_STRICT_MODE" "$(env_get "MYSQL_INNODB_STRICT_MODE")" || true
[ -n "$(env_get "MYSQL_INNODB_USE_NATIVE_AIO")" ] && env_set "MYSQL_INNODB_USE_NATIVE_AIO" "$(env_get "MYSQL_INNODB_USE_NATIVE_AIO")" || true
[ -n "$(env_get "MYSQL_INNODB_WRITE_IO_THREADS")" ] && env_set "MYSQL_INNODB_WRITE_IO_THREADS" "$(env_get "MYSQL_INNODB_WRITE_IO_THREADS")" || true
[ -n "$(env_get "MYSQL_INTERACTIVE_TIMEOUT")" ] && env_set "MYSQL_INTERACTIVE_TIMEOUT" "$(env_get "MYSQL_INTERACTIVE_TIMEOUT")" || true
[ -n "$(env_get "MYSQL_JOIN_BUFFER_SIZE")" ] && env_set "MYSQL_JOIN_BUFFER_SIZE" "$(env_get "MYSQL_JOIN_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_KEY_BUFFER_SIZE")" ] && env_set "MYSQL_KEY_BUFFER_SIZE" "$(env_get "MYSQL_KEY_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_LOG_BIN")" ] && env_set "MYSQL_LOG_BIN" "$(env_get "MYSQL_LOG_BIN")" || true
[ -n "$(env_get "MYSQL_LOG_WARNINGS")" ] && env_set "MYSQL_LOG_WARNINGS" "$(env_get "MYSQL_LOG_WARNINGS")" || true
[ -n "$(env_get "MYSQL_MAX_ALLOWED_PACKET")" ] && env_set "MYSQL_MAX_ALLOWED_PACKET" "$(env_get "MYSQL_MAX_ALLOWED_PACKET")" || true
[ -n "$(env_get "MYSQL_MAX_ALLOWED_PACKET")" ] && env_set "MYSQL_MAX_ALLOWED_PACKET" "$(env_get "MYSQL_MAX_ALLOWED_PACKET")" || true
[ -n "$(env_get "MYSQL_MAX_CONNECT_ERRORS")" ] && env_set "MYSQL_MAX_CONNECT_ERRORS" "$(env_get "MYSQL_MAX_CONNECT_ERRORS")" || true
[ -n "$(env_get "MYSQL_MAX_CONNECTIONS")" ] && env_set "MYSQL_MAX_CONNECTIONS" "$(env_get "MYSQL_MAX_CONNECTIONS")" || true
[ -n "$(env_get "MYSQL_MAX_HEAP_TABLE_SIZE")" ] && env_set "MYSQL_MAX_HEAP_TABLE_SIZE" "$(env_get "MYSQL_MAX_HEAP_TABLE_SIZE")" || true
[ -n "$(env_get "MYSQL_MYISAM_SORT_BUFFER_SIZE")" ] && env_set "MYSQL_MYISAM_SORT_BUFFER_SIZE" "$(env_get "MYSQL_MYISAM_SORT_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_MYISAMCHK_KEY_BUFFER_SIZE")" ] && env_set "MYSQL_MYISAMCHK_KEY_BUFFER_SIZE" "$(env_get "MYSQL_MYISAMCHK_KEY_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_MYISAMCHK_READ_BUFFER")" ] && env_set "MYSQL_MYISAMCHK_READ_BUFFER" "$(env_get "MYSQL_MYISAMCHK_READ_BUFFER")" || true
[ -n "$(env_get "MYSQL_MYISAMCHK_SORT_BUFFER_SIZE")" ] && env_set "MYSQL_MYISAMCHK_SORT_BUFFER_SIZE" "$(env_get "MYSQL_MYISAMCHK_SORT_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_MYISAMCHK_WRITE_BUFFER")" ] && env_set "MYSQL_MYISAMCHK_WRITE_BUFFER" "$(env_get "MYSQL_MYISAMCHK_WRITE_BUFFER")" || true
[ -n "$(env_get "MYSQL_NET_BUFFER_LENGTH")" ] && env_set "MYSQL_NET_BUFFER_LENGTH" "$(env_get "MYSQL_NET_BUFFER_LENGTH")" || true
[ -n "$(env_get "MYSQL_NET_READ_TIMEOUT")" ] && env_set "MYSQL_NET_READ_TIMEOUT" "$(env_get "MYSQL_NET_READ_TIMEOUT")" || true
[ -n "$(env_get "MYSQL_NET_WRITE_TIMEOUT")" ] && env_set "MYSQL_NET_WRITE_TIMEOUT" "$(env_get "MYSQL_NET_WRITE_TIMEOUT")" || true
[ -n "$(env_get "MYSQL_OPEN_FILES_LIMIT")" ] && env_set "MYSQL_OPEN_FILES_LIMIT" "$(env_get "MYSQL_OPEN_FILES_LIMIT")" || true
[ -n "$(env_get "MYSQL_OPTIMIZER_PRUNE_LEVEL")" ] && env_set "MYSQL_OPTIMIZER_PRUNE_LEVEL" "$(env_get "MYSQL_OPTIMIZER_PRUNE_LEVEL")" || true
[ -n "$(env_get "MYSQL_OPTIMIZER_SEARCH_DEPTH")" ] && env_set "MYSQL_OPTIMIZER_SEARCH_DEPTH" "$(env_get "MYSQL_OPTIMIZER_SEARCH_DEPTH")" || true
[ -n "$(env_get "MYSQL_PERFORMANCE_SCHEMA")" ] && env_set "MYSQL_PERFORMANCE_SCHEMA" "$(env_get "MYSQL_PERFORMANCE_SCHEMA")" || true
[ -n "$(env_get "MYSQL_PERFORMANCE_SCHEMA")" ] && env_set "MYSQL_PERFORMANCE_SCHEMA" "$(env_get "MYSQL_PERFORMANCE_SCHEMA")" || true
[ -n "$(env_get "MYSQL_QUERY_CACHE_LIMIT")" ] && env_set "MYSQL_QUERY_CACHE_LIMIT" "$(env_get "MYSQL_QUERY_CACHE_LIMIT")" || true
[ -n "$(env_get "MYSQL_QUERY_CACHE_MIN_RES_UNIT")" ] && env_set "MYSQL_QUERY_CACHE_MIN_RES_UNIT" "$(env_get "MYSQL_QUERY_CACHE_MIN_RES_UNIT")" || true
[ -n "$(env_get "MYSQL_QUERY_CACHE_SIZE")" ] && env_set "MYSQL_QUERY_CACHE_SIZE" "$(env_get "MYSQL_QUERY_CACHE_SIZE")" || true
[ -n "$(env_get "MYSQL_QUERY_CACHE_TYPE")" ] && env_set "MYSQL_QUERY_CACHE_TYPE" "$(env_get "MYSQL_QUERY_CACHE_TYPE")" || true
[ -n "$(env_get "MYSQL_READ_BUFFER_SIZE")" ] && env_set "MYSQL_READ_BUFFER_SIZE" "$(env_get "MYSQL_READ_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_READ_RND_BUFFER_SIZE")" ] && env_set "MYSQL_READ_RND_BUFFER_SIZE" "$(env_get "MYSQL_READ_RND_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_RELAY_LOG_RECOVERY")" ] && env_set "MYSQL_RELAY_LOG_RECOVERY" "$(env_get "MYSQL_RELAY_LOG_RECOVERY")" || true
[ -n "$(env_get "MYSQL_SERVER_ID")" ] && env_set "MYSQL_SERVER_ID" "$(env_get "MYSQL_SERVER_ID")" || true
[ -n "$(env_get "MYSQL_SLOW_QUERY_LOG")" ] && env_set "MYSQL_SLOW_QUERY_LOG" "$(env_get "MYSQL_SLOW_QUERY_LOG")" || true
[ -n "$(env_get "MYSQL_SORT_BUFFER_SIZE")" ] && env_set "MYSQL_SORT_BUFFER_SIZE" "$(env_get "MYSQL_SORT_BUFFER_SIZE")" || true
[ -n "$(env_get "MYSQL_TABLE_DEFINITION_CACHE")" ] && env_set "MYSQL_TABLE_DEFINITION_CACHE" "$(env_get "MYSQL_TABLE_DEFINITION_CACHE")" || true
[ -n "$(env_get "MYSQL_THREAD_CACHE_SIZE")" ] && env_set "MYSQL_THREAD_CACHE_SIZE" "$(env_get "MYSQL_THREAD_CACHE_SIZE")" || true
[ -n "$(env_get "MYSQL_TMP_TABLE_SIZE")" ] && env_set "MYSQL_TMP_TABLE_SIZE" "$(env_get "MYSQL_TMP_TABLE_SIZE")" || true
[ -n "$(env_get "MYSQL_TRANSACTION_ISOLATION")" ] && env_set "MYSQL_TRANSACTION_ISOLATION" "$(env_get "MYSQL_TRANSACTION_ISOLATION")" || true
[ -n "$(env_get "MYSQL_WAIT_TIMEOUT")" ] && env_set "MYSQL_WAIT_TIMEOUT" "$(env_get "MYSQL_WAIT_TIMEOUT")" || true
[ -n "$(env_get "TIMEZONE")" ] && env_set "TIMEZONE" "$(env_get "TIMEZONE")" || true



# Environnement variables which must exist
[ -z "$(env_get "MYSQL_DATA_DIR")" ]                && env_set "MYSQL_DATA_DIR" "$(env_get "MARIADB_DATA_DIR")" || true
[ -z "$(env_get "MYSQL_CONFIG_DIR")" ]              && env_set "MYSQL_CONFIG_DIR" "$(env_get "MARIADB_CONFIG_DIR")" || true
[ -z "$(env_get "MYSQL_BACKUP_DIR")" ]              && env_set "MYSQL_BACKUP_DIR" "$(env_get "MARIADB_BACKUP_DIR")" || true
[ -z "$(env_get "MYSQL_LOG_DIR")" ]                 && env_set "MYSQL_LOG_DIR" "$(env_get "MARIADB_LOG_DIR")" || true
