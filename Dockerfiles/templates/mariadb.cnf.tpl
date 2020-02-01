# The following options will be passed to all MySQL clients
[client]
port		              = 3306
socket		              = /run/mariadb/mariadb.sock
default-character-set     = {{MYSQL_CLIENT_DEFAULT_CHARACTER_SET=utf8}}

# The MariaDB server
[mysqld]
user                      = {{MARIADB_USER}}
port		              = 3306
socket		              = /run/mariadb/mariadb.sock
pid-file		          = /run/mariadb/mariadb.pid
basedir                   = /usr
datadir                   = {{MYSQL_DATA_DIR}}
default-time-zone         = {{TIMEZONE=+00:00}}

skip-character-set-client-handshake
skip-external-locking
skip-name-resolve

collation-server          = {{MYSQL_COLLATION_SERVER=utf8mb4_general_ci}}
init_connect              = '{{MYSQL_INIT_CONNECT="SET NAMES utf8mb4"}}'
character-set-server      = {{MYSQL_CHARACTER_SET_SERVER=utf8mb4}}
character_set_filesystem  = {{MYSQL_CHARACTER_SET_FILESYSTEM=utf8mb4}}

symbolic-links            = 0
default_storage_engine    = {{MYSQL_DEFAULT_STORAGE_ENGINE=InnoDB}}

join_buffer_size          = {{MYSQL_JOIN_BUFFER_SIZE=8M}}
max_heap_table_size       = {{MYSQL_MAX_HEAP_TABLE_SIZE=16M}}
query_cache_limit         = {{MYSQL_QUERY_CACHE_LIMIT=1M}}
query_cache_min_res_unit  = {{MYSQL_QUERY_CACHE_MIN_RES_UNIT=4K}}
query_cache_size          = {{MYSQL_QUERY_CACHE_SIZE=128M}}
query_cache_type          = {{MYSQL_QUERY_CACHE_TYPE=ON}}
sort_buffer_size          = {{MYSQL_SORT_BUFFER_SIZE=2M}}
table_definition_cache    = {{MYSQL_TABLE_DEFINITION_CACHE=400}}
table_open_cache          = {{MYSQL_TABLE_OPEN_CACHE=400}}
thread_cache_size         = {{MYSQL_THREAD_CACHE_SIZE=75}}
tmp_table_size            = {{MYSQL_TMP_TABLE_SIZE=16M}}
key_buffer_size           = {{MYSQL_KEY_BUFFER_SIZE=256M}}
net_buffer_length         = {{MYSQL_NET_BUFFER_LENGTH=1M}}
read_buffer_size          = {{MYSQL_READ_BUFFER_SIZE=2M}}
read_rnd_buffer_size      = {{MYSQL_READ_RND_BUFFER_SIZE=2M}}
myisam_sort_buffer_size   = {{MYSQL_MYISAM_SORT_BUFFER_SIZE=2M}}

max_allowed_packet        = {{MYSQL_MAX_ALLOWED_PACKET=256M}}
max_connect_errors        = {{MYSQL_MAX_CONNECT_ERRORS=100000}}
max_connections           = {{MYSQL_MAX_CONNECTIONS=100}}
open_files_limit          = {{MYSQL_OPEN_FILES_LIMIT=0}}

performance_schema        = {{MYSQL_PERFORMANCE_SCHEMA=OFF}}

transaction-isolation     = {{MYSQL_TRANSACTION_ISOLATION=READ-COMMITTED}}

# logs
general_log               = {{MYSQL_GENERAL_LOG=0}}
general_log_file          = {{MYSQL_LOG_DIR}}/mysql.log
slow-query-log            = {{MYSQL_SLOW_QUERY_LOG=0}}
slow-query-log-file       = {{MYSQL_LOG_DIR}}/mysql-slow.log

back_log                  = {{MYSQL_BACK_LOG=100}}
log_warnings              = {{MYSQL_LOG_WARNINGS=2}}
relay_log_recovery        = {{MYSQL_RELAY_LOG_RECOVERY=0}}

# waits
net_write_timeout         = {{MYSQL_NET_WRITE_TIMEOUT=90}}
net_read_timeout          = {{MYSQL_NET_READ_TIMEOUT=90}}
wait_timeout              = {{MYSQL_WAIT_TIMEOUT=420}}
interactive_timeout       = {{MYSQL_INTERACTIVE_TIMEOUT=420}}

# Point the following paths to different dedicated disks
tmpdir = /mariadb/tmp

# Don't listen on a TCP/IP port at all. This can be a security enhancement,
# if all processes that need to connect to mysqld run on the same host.
# All interaction with mysqld must be made via Unix sockets or named pipes.
# Note that using this option without enabling named pipes on Windows
# (via the "enable-named-pipe" option) will render mysqld useless!
#
#skip-networking
#skip-name-resolve
bind-address = {{MYSQL_BIND_ADRESS=0.0.0.0}}

# Replication Master Server (default)
# binary logging is required for replication
log-bin = {{MYSQL_LOG_BIN=mysql-bin}}

# binary logging format - mixed recommended
binlog_format = {{MYSQL_BINLOG_FORMAT=mixed}}

# required unique id between 1 and 2^32 - 1
# defaults to 1 if master-host is not set
# but will not function as a master if omitted
server-id = {{MYSQL_SERVER_ID=1}}

# InnoDB tables
innodb_buffer_pool_instances            = {{MYSQL_INNODB_BUFFER_POOL_INSTANCES=1}}
innodb_buffer_pool_size                 = {{MYSQL_INNODB_BUFFER_POOL_SIZE=128M}}
innodb_data_home_dir                    = {{MARIADB_DATA_DIR}}
innodb_data_file_path                   = {{MYSQL_INNODB_DATA_FILE_PATH=ibdata1:10M:autoextend:max:10G}}
innodb_default_row_format               = {{MYSQL_INNODB_DEFAULT_ROW_FORMAT=dynamic}}
innodb_empty_free_list_algorithm        = {{MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM=legacy}}
innodb_fast_shutdown                    = {{MYSQL_INNODB_FAST_SHUTDOWN=1}}
innodb_file_format                      = {{MYSQL_INNODB_FILE_FORMAT=Antelope}}
innodb_file_per_table                   = {{MYSQL_INNODB_FILE_PER_TABLE=1}}
innodb_flush_log_at_trx_commit          = {{MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT=2}}
innodb_flush_method                     = {{MYSQL_INNODB_FLUSH_METHOD=O_DIRECT}}
innodb_force_load_corrupted             = {{MYSQL_INNODB_FORCE_LOAD_CORRUPTED=0}}
innodb_force_recovery                   = {{MYSQL_INNODB_FORCE_RECOVERY=0}}
innodb_io_capacity                      = {{MYSQL_INNODB_IO_CAPACITY=200}}
innodb_large_prefix                     = {{MYSQL_INNODB_LARGE_PREFIX=OFF}}
innodb_lock_wait_timeout                = {{MYSQL_INNODB_LOCK_WAIT_TIMEOUT=50}}
innodb_log_buffer_size                  = {{MYSQL_INNODB_LOG_BUFFER_SIZE=8M}}
innodb_log_file_size                    = {{MYSQL_INNODB_LOG_FILE_SIZE=128M}}
innodb_log_files_in_group               = {{MYSQL_INNODB_LOG_FILES_IN_GROUP=2}}
innodb_log_group_home_dir               = {{MARIADB_DATA_DIR}}
innodb_old_blocks_time                  = {{MYSQL_INNODB_OLD_BLOCKS_TIME=1000}}
innodb_open_files                       = {{MYSQL_INNODB_OPEN_FILES=512}}
innodb_purge_threads                    = {{MYSQL_INNODB_PURGE_THREADS=4}}
innodb_read_io_threads                  = {{MYSQL_INNODB_READ_IO_THREADS=4}}
innodb_stats_on_metadata                = {{MYSQL_INNODB_STATS_ON_METADATA=OFF}}
innodb_strict_mode                      = {{MYSQL_INNODB_STRICT_MODE=OFF}}
innodb_use_native_aio                   = {{MYSQL_INNODB_USE_NATIVE_AIO=1}}
innodb_write_io_threads                 = {{MYSQL_INNODB_WRITE_IO_THREADS=4}}

# Optimizer
optimizer_prune_level   = {{MYSQL_OPTIMIZER_PRUNE_LEVEL=1}}
optimizer_search_depth  = {{MYSQL_OPTIMIZER_SEARCH_DEPTH=62}}

[mysqldump]
quick
quote-names
max_allowed_packet      = {{MYSQL_DUMP_MAX_ALLOWED_PACKET=1G}}

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size         = {{MYSQL_MYISAMCHK_KEY_BUFFER_SIZE=128M}}
sort_buffer_size        = {{MYSQL_MYISAMCHK_SORT_BUFFER_SIZE=128M}}
read_buffer             = {{MYSQL_MYISAMCHK_READ_BUFFER=2M}}
write_buffer            = {{MYSQL_MYISAMCHK_WRITE_BUFFER=2M}}

[mysqlhotcopy]
interactive-timeout

# Include all files in conf.d folder
!includedir {{MARIADB_CONFIG_DIR}}/conf.d/
