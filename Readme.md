# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) MariaDB
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/mariadb/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/mariadb/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/mariadb.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/mariadb.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/mariadb/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/mariadb/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)

This is a docker image for [MariaDB][MariaDB] database running on [Alpine container][alpine-runit] with [runit][runit] process supervisor.

>![](https://github.com/docker-suite/artwork/raw/master/various/warning/png/warning_16.png) Known issue with bind mounts on macOS and Windows
>
>Latest MariaDB will fail to start on macOS and Windows with `Probably out of disk space` if you **use bind mounts** (volumes mounted from host). This (likely) happens because of recent changes in InnoDB, this bug addressed in [MariaDB JIRA](https://jira.mariadb.org/browse/MDEV-16015).
>
>Solutions:
>
>* Use MariaDB 10.1
>* Not to use bind mounts, let docker manage volumes, since docker-ce 17.06 it won't clean up your volumes with `docker system prune` unless you specify `--volumes` flag
>* Try `--innodb-flush-method=fsync`

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes

- **/mariadb**
    - `/mariadb/config` : contains mariadb configuration file (mariadb.cnf)
    - `/mariadb/config/conf.d/` : any configuration files placed in this folder are included by mariadb.cnf
    - `/mariadb/data` : database folder
    - `/mariadb/backup` : backup folder
- **/var/log/mariadb**
    - `/var/log/mariadb` : logs folder if general log or slow query log is enable 

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports

- 3306

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Environment variables

| Variable | Value | Info |
|----------|-------|------|
| `MYSQL_ROOT_PASSWORD` |  | Set the root password |
| `MYSQL_ALLOW_EMPTY_PASSWORD` | `false` | Enable empty password (true or false) |
| `MYSQL_RANDOM_ROOT_PASSWORD` | `false` | Generate random root password (true or false) |
| `MYSQL_DATABASE` |  | Create a database as provided by input |
| `MYSQL_USER` |  | Create a user with owner permissions over said database |
| `MYSQL_PASSWORD` |  | Change password of the provided user (not root) |
| `MYSQL_DATA_DIR` | `/mariadb/data/` | Change mysql default directory |
| `MYSQL_INSTALL_PARAMS` |  | Add parameters to mysql_install_db</br><sub>⚠️try to set to --innodb-flush-method=fsync to persist volume on windows</sub> |
| `MYSQL_STARTCMD` | `/usr/bin/mysqld` | Default start command |
| `MYSQL_STARTPARAMS` | `--skip-host-cache --skip-name-resolve --debug-gdb` | Default start parameters |
| `MYSQL_BACKUP_DIR` | `/mariadb/backup ` | Folder used to store backups |
| `MYSQL_BACKUP_COUNT` | `14` | Retaining days |
| `MYSQL_LOG_DIR` | `/var/log/mariadb` | Log folder |

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Environment variables (config)

| Variable | 10.4 | 10.3 | 10.2 | 10.1 |
|----------|------|------|------|------|
| `MYSQL_BIND_ADRESS` | `0.0.0.0` | `0.0.0.0` | `0.0.0.0` | `0.0.0.0` |
| `MYSQL_BINLOG_FORMAT` | `mixed` | `mixed` | `mixed` | `mixed` |
| `MYSQL_CHARACTER_SET_FILESYSTEM` | `utf8mb4` | `utf8mb4` | `utf8mb4` | `utf8mb4` |
| `MYSQL_CHARACTER_SET_SERVER` | `utf8mb4` | `utf8mb4` | `utf8mb4` | `utf8mb4` |
| `MYSQL_CLIENT_DEFAULT_CHARACTER_SET` | `utf8mb4` | `utf8mb4` | `utf8mb4` | `utf8mb4` |
| `MYSQL_COLLATION_SERVER` | `utf8mb4_general_ci` | `utf8mb4_general_ci` | `utf8mb4_general_ci` | `utf8mb4_general_ci` |
| `MYSQL_DEFAULT_STORAGE_ENGINE` | `InnoDB` | `InnoDB` | `InnoDB` | `InnoDB` |
| `MYSQL_DUMP_MAX_ALLOWED_PACKET` | `1G` | `1G` | `1G` | `1G` |
| `MYSQL_GENERAL_LOG` | `0` | `0` | `0` | `0` |
| `MYSQL_INIT_CONNECT` | `SET NAMES utf8` | `SET NAMES utf8` | `SET NAMES utf8` | `SET NAMES utf8` |
| `MYSQL_INNODB_BUFFER_POOL_INSTANCES` | `1` | `1` | `1` | `1` |
| `MYSQL_INNODB_BUFFER_POOL_SIZE` | `128M` | `128M` | `128M` | `128M` |
| `MYSQL_INNODB_DATA_FILE_PATH` | `ibdata1:10M:autoextend:max:10G` | `ibdata1:10M:autoextend:max:10G` | `ibdata1:10M:autoextend:max:10G` | `ibdata1:10M:autoextend:max:10G` |
| `MYSQL_INNODB_DEFAULT_ROW_FORMAT` | `dynamic` | `dynamic` | `dynamic` | `dynamic` |
| `MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM` | `legacy` | `legacy` | `legacy` | `legacy` |
| `MYSQL_INNODB_FAST_SHUTDOWN` | `1` | `1` | `1` | `1` |
| `MYSQL_INNODB_FILE_FORMAT` | `Antelope` | `Antelope` | `Antelope` | `Antelope` |
| `MYSQL_INNODB_FILE_PER_TABLE` | `1` | `1` | `1` | `1` |
| `MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT` | `2` | `2` | `2` | `2` |
| `MYSQL_INNODB_FLUSH_METHOD` | `O_DIRECT` | `O_DIRECT` | `O_DIRECT` | `O_DIRECT` |
| `MYSQL_INNODB_FORCE_LOAD_CORRUPTED` | `0` | `0` | `0` | `0` |
| `MYSQL_INNODB_FORCE_RECOVERY` | `0` | `0` | `0` | `0` |
| `MYSQL_INNODB_IO_CAPACITY` | `200` | `200` | `200` | `200` |
| `MYSQL_INNODB_LARGE_PREFIX` | `OFF` | `OFF` | `OFF` | `OFF` |
| `MYSQL_INNODB_LOCK_WAIT_TIMEOUT` | `50` | `50` | `50` | `50` |
| `MYSQL_INNODB_LOG_BUFFER_SIZE` | `8M` | `8M` | `8M` | `8M` |
| `MYSQL_INNODB_LOG_FILE_SIZE` | `128M` | `128M` | `128M` | `128M` |
| `MYSQL_INNODB_LOG_FILES_IN_GROUP` | `2` | `2` | `2` | `2` |
| `MYSQL_INNODB_OLD_BLOCKS_TIME` | `1000` | `1000` | `1000` | `1000` |
| `MYSQL_INNODB_OPEN_FILES` | `512` | `512` | `512` | `512` |
| `MYSQL_INNODB_PURGE_THREADS` | `4` | `4` | `4` | `4` |
| `MYSQL_INNODB_READ_IO_THREADS` | `4` | `4` | `4` | `4` |
| `MYSQL_INNODB_STATS_ON_METADATA` | `OFF` | `OFF` | `OFF` | `OFF` |
| `MYSQL_INNODB_STRICT_MODE` | `OFF` | `OFF` | `OFF` | `OFF` |
| `MYSQL_INNODB_USE_NATIVE_AIO` | `1` | `1` | `1` | `1` |
| `MYSQL_INNODB_WRITE_IO_THREADS` | `4` | `4` | `4` | `4` |
| `MYSQL_INTERACTIVE_TIMEOUT` | `420` | `420` | `420` | `420` |
| `MYSQL_JOIN_BUFFER_SIZE` | `8M` | `8M` | `8M` | `8M` |
| `MYSQL_KEY_BUFFER_SIZE` | `256M` | `256M` | `256M` | `256M` |
| `MYSQL_LOG_BIN` | `mysql-bin` | `mysql-bin` | `mysql-bin` | `mysql-bin` |
| `MYSQL_LOG_WARNINGS` | `2` | `2` | `2` | `2` |
| `MYSQL_MAX_ALLOWED_PACKET` | `256M` | `256M` | `256M` | `256M` |
| `MYSQL_MAX_ALLOWED_PACKET` | `256M` | `256M` | `256M` | `256M` |
| `MYSQL_MAX_CONNECT_ERRORS` | `100000` | `100000` | `100000` | `100000` |
| `MYSQL_MAX_CONNECTIONS` | `100` | `100` | `100` | `100` |
| `MYSQL_MAX_HEAP_TABLE_SIZE` | `16M` | `16M` | `16M` | `16M` |
| `MYSQL_MYISAM_SORT_BUFFER_SIZE` | `2M` | `2M` | `2M` | `2M` |
| `MYSQL_MYISAMCHK_KEY_BUFFER_SIZE` | `128M` | `128M` | `128M` | `128M` |
| `MYSQL_MYISAMCHK_READ_BUFFER` | `2M` | `2M` | `2M` | `2M` |
| `MYSQL_MYISAMCHK_SORT_BUFFER_SIZE` | `128M` | `128M` | `128M` | `128M` |
| `MYSQL_MYISAMCHK_WRITE_BUFFER` | `2M` | `2M` | `2M` | `2M` |
| `MYSQL_NET_BUFFER_LENGTH` | `1M` | `1M` | `1M` | `1M` |
| `MYSQL_NET_READ_TIMEOUT` | `90` | `90` | `90` | `90` |
| `MYSQL_NET_WRITE_TIMEOUT` | `90` | `90` | `90` | `90` |
| `MYSQL_OPEN_FILES_LIMIT` | `0` | `0` | `0` | `0` |
| `MYSQL_OPTIMIZER_PRUNE_LEVEL` | `1` | `1` | `1` | `1` |
| `MYSQL_OPTIMIZER_SEARCH_DEPTH` | `62` | `62` | `62` | `62` |
| `MYSQL_PERFORMANCE_SCHEMA` | `OFF` | `OFF` | `OFF` | `OFF` |
| `MYSQL_PERFORMANCE_SCHEMA` | `OFF` | `OFF` | `OFF` | `OFF` |
| `MYSQL_QUERY_CACHE_LIMIT` | `1M` | `1M` | `1M` | `1M` |
| `MYSQL_QUERY_CACHE_MIN_RES_UNIT` | `4K` | `4K` | `4K` | `4K` |
| `MYSQL_QUERY_CACHE_SIZE` | `128M` | `128M` | `128M` | `128M` |
| `MYSQL_QUERY_CACHE_TYPE` | `ON` | `ON` | `ON` | `ON` |
| `MYSQL_READ_BUFFER_SIZE` | `2M` | `2M` | `2M` | `2M` |
| `MYSQL_READ_RND_BUFFER_SIZE` | `2M` | `2M` | `2M` | `2M` |
| `MYSQL_RELAY_LOG_RECOVERY` | `0` | `0` | `0` | `0` |
| `MYSQL_SERVER_ID` | `1` | `1` | `1` | `1` |
| `MYSQL_SLOW_QUERY_LOG` | `0` | `0` | `0` | `0` |
| `MYSQL_SORT_BUFFER_SIZE` | `2M` | `2M` | `2M` | `2M` |
| `MYSQL_TABLE_DEFINITION_CACHE` | `400` | `400` | `400` | `400` |
| `MYSQL_THREAD_CACHE_SIZE` | `75` | `75` | `75` | `75` |
| `MYSQL_TMP_TABLE_SIZE` | `16M` | `16M` | `16M` | `16M` |
| `MYSQL_TRANSACTION_ISOLATION` | `READ-COMMITTED` | `READ-COMMITTED` | `READ-COMMITTED` | `READ-COMMITTED` |
| `MYSQL_WAIT_TIMEOUT` | `420` | `420` | `420` | `420` |
| `TIMEZONE` | `+00:00` | `+00:00` | `+00:00` | `+00:00` |


[`MYSQL_BIND_ADRESS`]: https://mariadb.com/kb/en/library/server-system-variables/#bind_address
[`MYSQL_BINLOG_FORMAT`]: https://mariadb.com/kb/en/library/replication-and-binary-log-system-variables/#binlog_format
[`MYSQL_CHARACTER_SET_SERVER`]: https://mariadb.com/kb/en/library/server-system-variables/#character_set_server
[`MYSQL_CLIENT_DEFAULT_CHARACTER_SET`]: https://mariadb.com/kb/en/library/mysql-client-utility-character-set/
[`MYSQL_COLLATION_SERVER`]: https://mariadb.com/kb/en/library/server-system-variables/#collation_server
[`MYSQL_DUMP_MAX_ALLOWED_PACKET`]: https://mariadb.com/kb/en/library/mysqldump/
[`MYSQL_GENERAL_LOG`]: https://mariadb.com/kb/en/library/server-system-variables/#general_log
[`MYSQL_INNODB_BUFFER_POOL_SIZE`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_buffer_pool_size
[`MYSQL_INNODB_DATA_FILE_PATH`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_data_file_path
[`MYSQL_INNODB_DEFAULT_ROW_FORMAT`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables/#innodb_default_row_format
[`MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables/#innodb_default_row_format
[`MYSQL_INNODB_FILE_FORMAT`]: https://mariadb.com/kb/en/library/innodb-system-variables/#innodb_empty_free_list_algorithm
[`MYSQL_INNODB_FILE_PER_TABLE`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_file_per_table
[`MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_flush_log_at_trx_commit
[`MYSQL_INNODB_LARGE_PREFIX`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_large_prefix
[`MYSQL_INNODB_LOCK_WAIT_TIMEOUT`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_lock_wait_timeout
[`MYSQL_INNODB_LOG_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_log_buffer_size
[`MYSQL_INNODB_LOG_FILE_SIZE`]: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_log_file_size
[`MYSQL_INNODB_USE_NATIVE_AIO`]: https://mariadb.com/kb/en/library/innodb-system-variables/#innodb_use_native_aio
[`MYSQL_KEY_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/myisam-system-variables/#key_buffer_size
[`MYSQL_LOG_BIN`]: https://mariadb.com/kb/en/library/replication-and-binary-log-system-variables/#log_bin
[`MYSQL_MAX_ALLOWED_PACKET`]: https://mariadb.com/kb/en/library/server-system-variables/#max_allowed_packet
[`MYSQL_MYISAM_SORT_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/myisam-system-variables/#myisam_sort_buffer_size
[`MYSQL_MYISAMCHK_KEY_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/myisamchk/
[`MYSQL_MYISAMCHK_READ_BUFFER`]: https://mariadb.com/kb/en/library/myisamchk/
[`MYSQL_MYISAMCHK_SORT_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/myisamchk/
[`MYSQL_MYISAMCHK_WRITE_BUFFER`]: https://mariadb.com/kb/en/library/myisamchk/
[`MYSQL_NET_BUFFER_LENGTH`]: https://mariadb.com/kb/en/library/server-system-variables/#net_buffer_length
[`MYSQL_OPTIMIZER_PRUNE_LEVEL`]: https://mariadb.com/kb/en/library/server-system-variables/#optimizer_prune_level
[`MYSQL_OPTIMIZER_SEARCH_DEPTH`]: https://mariadb.com/kb/en/library/server-system-variables/#optimizer_search_depth
[`MYSQL_READ_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/server-system-variables/#read_buffer_size
[`MYSQL_READ_RND_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/server-system-variables/#read_rnd_buffer_size
[`MYSQL_SERVER_ID`]: https://mariadb.com/kb/en/replication-and-binary-log-server-system-variables/#server_id
[`MYSQL_SLOW_QUERY_LOG`]: https://mariadb.com/kb/en/library/server-system-variables/#slow_query_log
[`MYSQL_SORT_BUFFER_SIZE`]: https://mariadb.com/kb/en/library/server-system-variables/#sort_buffer_size
[`MYSQL_TABLE_OPEN_CACHE`]: https://mariadb.com/kb/en/library/server-system-variables/#table_open_cache
[`MYSQL_TRANSACTION_ISOLATION`]: https://mariadb.com/kb/en/library/set-transaction/
[`TIMEZONE`]: https://mariadb.com/kb/en/library/time-zones/

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to use this image

**Build:**

```Dockerfile
docker build -t dsuite/mariadb .
```

**Typical usage:**

```Dockerfile
docker run -d --name=mariadb \
        -e MYSQL_ROOT_PASSWORD=<secretpassword> \
        -e MYSQL_DATABASE=<databasename> \
        -e MYSQL_USER=<username> \
        -e MYSQL_PASSWORD=<password> \
        -v $(PWD)/mariadb/:/mariadb \
            dsuite/mariadb
```

**Don't want to enable remote access client:**  
Change the `MYSQL_STARTPARAMS` environment variables to: `--skip-networking --skip-host-cache --skip-name-resolve --debug-gdb`

```Dockerfile
docker run -d --name=mariadb \
        -p 3306:3306 \
        -e MYSQL_ROOT_PASSWORD=<secretpassword> \
        -e MYSQL_DATABASE=<databasename> \
        -e MYSQL_USER=<username> \
        -e MYSQL_PASSWORD=<password> \
        -e MYSQL_STARTPARAMS='--skip-networking --skip-host-cache --skip-name-resolve --debug-gdb' \
        -v $(PWD)/mariadb/:/mariadb \
            dsuite/mariadb
```

**Persistent volume on windows** (⚠️ may or may not work !)

```Dockerfile
docker run -d --name=mariadb \
        -p 3306:3306 \
        -e MYSQL_ROOT_PASSWORD=<secretpassword> \
        -e MYSQL_DATABASE=<databasename> \
        -e MYSQL_USER=<username> \
        -e MYSQL_PASSWORD=<password> \
        -e MYSQL_INSTALL_PARAMS='--innodb-flush-method=fsync' \
        -v $(PWD)/mariadb/:/mariadb \
            dsuite/mariadb
```

To **start** or **stop** MariaDB, get a bash command prompt inside the container:

```bash
docker exec -it mariadb bash

# Start mariadb
runit service mariadb start
# Stop mariadb
runit service mariadb stop
# Restart mariadb
runit service mariadb restart
# Status of mariadb
runit service mariadb status

# Stop all services
runit stop
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Performance Tuning

Use [MySQLTuner][mysqltuner] to assist you with your MySQL configuration:

```Dockerfile
    docker run -it --rm dsuite/mysqltuner \
            --host <hostname> \
            --user <username> \
            --pass <password> \
            --forcemem <size> \
            --forceswap <size>
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Performance Tuning Recommendations

### Optimizer search depth

Decrease the value of `MYSQL_OPTIMIZER_SEARCH_DEPTH` to 7-8 if you have many queries with more than 15 tables ([source](https://mariadb.com/resources/blog/setting-optimizer-search-depth-mysql))

### Calculating the optimal size of `innodb_buffer_pool_size`

Run the following query to get the recommend innodb buffer pool size:

```sql
SELECT CONCAT(CEILING(RIBPS/POWER(1024,pw)),SUBSTR(' KMGT',pw+1,1))
Recommended_InnoDB_Buffer_Pool_Size FROM
(
    SELECT RIBPS,FLOOR(LOG(RIBPS)/LOG(1024)) pw
    FROM
    (
        SELECT SUM(data_length+index_length)*1.1*growth RIBPS
        FROM information_schema.tables AAA,
        (SELECT 1.25 growth) BBB
        WHERE ENGINE='InnoDB'
    ) AA
) A;
```

Source: from [stack exchange](https://dba.stackexchange.com/a/27472/134547).


[alpine]: http://alpinelinux.org/
[runit]: http://smarden.org/runit/
[MariaDB]: https://mariadb.org/
[alpine-runit]: https://github.com/docker-suite/alpine-runit
[mysqltuner]: https://github.com/docker-suite/mysqltuner
