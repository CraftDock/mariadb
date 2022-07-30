# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) MariaDB
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/mariadb/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/mariadb/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/mariadb.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/mariadb.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/mariadb/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/mariadb/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)

This is a docker image for [MariaDB][MariaDB] database based on [official MariaDb](https://hub.docker.com/_/mariadb) image.

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes

- `/docker-entrypoint-initdb.d` : all sql files present in this folder whill be executed at startup.
- `/etc/mysql/conf.d` : Place your startup configuration files here.
- `/var/lib/mysql` : MariaDb data folder.
- `/backup` : backup folder used by `backup_cron.sh`.

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports

- 3306

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Environment variables

For **default MariaDb environment variables**, check the official [docker hub page](https://hub.docker.com/_/mariadb).

| Variable | Value | Info |
|----------|-------|------|
| `BACKUP_MYSQL_HOST`  |  | The host/ip of your mysql database |
| `BACKUP_MYSQL_PORT` | 3306 | The port number of your mysql database |
| `MYSQL_USER` |  | The username of your mysql database |
| `MYSQL_PASSWORD` |  | The password of your mysql database |
| `MYSQL_PASS_FILE` |  | The file in container where to find the password of your mysql database (cf. docker secrets). You should use either MYSQL_PASS_FILE or MYSQL_PASS (see examples below). |
| `BACKUP_DATABASE` |  | The database name to dump. Default: --all-databases. |
| `BACKUP_DUMP_OPTS` |  | Command line arguments to pass to mysqldump (see mysqldump documentation). |
| `MYSQL_SSL_OPTS` |  | Command line arguments to use SSL |
| `BACKUP_CRON_TIME` | 0 3 * * * | The interval of cron job to run mysqldump |
| `BACKUP_USE_PLAIN_SQL` |  | If set, back up and restore plain SQL files without gzip |
| `BACKUP_RETENTION_DAYS` |  | The number of days to keep. When reaching the limit, the old backup will be discarded. No limit by default. |
| `BACKUP_MAX_BACKUPS` |  | The number of backups to keep. When reaching the limit, the old backup will be discarded. No limit by default. |
| `BACKUP_TIMEOUT` |  | Wait a given number of seconds for the database to be ready and make the first backup, 10s by default. After that time, the initial attempt for backup gives up and only the Cron job will try to make a backup. |
| `BACKUP_GZIP_LEVEL` |  | Specify the level of gzip compression from 1 (quickest, least compressed) to 9 (slowest, most compressed), default is 6. |


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Frequently used options

Here is a link list of frequently options used to configure you MariaDb server

For a quick explanation on how to edit MariaDb options, refer to : [Edit MariaDb options in docker or docker-compose](./Edit_MariaDb_options.md)

`MYSQL_BIND_ADRESS`: https://mariadb.com/kb/en/library/server-system-variables/#bind_address

`MYSQL_BINLOG_FORMAT`: https://mariadb.com/kb/en/library/replication-and-binary-log-system-variables/#binlog_format

`MYSQL_CHARACTER_SET_SERVER`: https://mariadb.com/kb/en/library/server-system-variables/#character_set_server

`MYSQL_CLIENT_DEFAULT_CHARACTER_SET`: https://mariadb.com/kb/en/library/mysql-client-utility-character-set/

`MYSQL_COLLATION_SERVER`: https://mariadb.com/kb/en/library/server-system-variables/#collation_server

`MYSQL_DUMP_MAX_ALLOWED_PACKET`: https://mariadb.com/kb/en/library/mysqldump/

`MYSQL_GENERAL_LOG`: https://mariadb.com/kb/en/library/server-system-variables/#general_log

`MYSQL_INNODB_BUFFER_POOL_SIZE`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_buffer_pool_size

`MYSQL_INNODB_DATA_FILE_PATH`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_data_file_path

`MYSQL_INNODB_DEFAULT_ROW_FORMAT`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables/#innodb_default_row_format

`MYSQL_INNODB_EMPTY_FREE_LIST_ALGORITHM`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables/#innodb_default_row_format

`MYSQL_INNODB_FILE_FORMAT`: https://mariadb.com/kb/en/library/innodb-system-variables/#innodb_empty_free_list_algorithm

`MYSQL_INNODB_FILE_PER_TABLE`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_file_per_table

`MYSQL_INNODB_FLUSH_LOG_AT_TRX_COMMIT`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_flush_log_at_trx_commit

`MYSQL_INNODB_LARGE_PREFIX`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_large_prefix

`MYSQL_INNODB_LOCK_WAIT_TIMEOUT`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_lock_wait_timeout

`MYSQL_INNODB_LOG_BUFFER_SIZE`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_log_buffer_size

`MYSQL_INNODB_LOG_FILE_SIZE`: https://mariadb.com/kb/en/library/xtradbinnodb-server-system-variables#innodb_log_file_size

`MYSQL_INNODB_USE_NATIVE_AIO`: https://mariadb.com/kb/en/library/innodb-system-variables/#innodb_use_native_aio

`MYSQL_KEY_BUFFER_SIZE`: https://mariadb.com/kb/en/library/myisam-system-variables/#key_buffer_size

`MYSQL_LOG_BIN`: https://mariadb.com/kb/en/library/replication-and-binary-log-system-variables/#log_bin

`MYSQL_MAX_ALLOWED_PACKET`: https://mariadb.com/kb/en/library/server-system-variables/#max_allowed_packet

`MYSQL_MYISAM_SORT_BUFFER_SIZE`: https://mariadb.com/kb/en/library/myisam-system-variables/#myisam_sort_buffer_size

`MYSQL_MYISAMCHK_KEY_BUFFER_SIZE`: https://mariadb.com/kb/en/library/myisamchk/

`MYSQL_MYISAMCHK_READ_BUFFER`: https://mariadb.com/kb/en/library/myisamchk/

`MYSQL_MYISAMCHK_SORT_BUFFER_SIZE`: https://mariadb.com/kb/en/library/myisamchk/

`MYSQL_MYISAMCHK_WRITE_BUFFER`: https://mariadb.com/kb/en/library/myisamchk/

`MYSQL_NET_BUFFER_LENGTH`: https://mariadb.com/kb/en/library/server-system-variables/#net_buffer_length

`MYSQL_OPTIMIZER_PRUNE_LEVEL`: https://mariadb.com/kb/en/library/server-system-variables/#optimizer_prune_level

`MYSQL_OPTIMIZER_SEARCH_DEPTH`: https://mariadb.com/kb/en/library/server-system-variables/#optimizer_search_depth

`MYSQL_READ_BUFFER_SIZE`: https://mariadb.com/kb/en/library/server-system-variables/#read_buffer_size

`MYSQL_READ_RND_BUFFER_SIZE`: https://mariadb.com/kb/en/library/server-system-variables/#read_rnd_buffer_size

`MYSQL_SERVER_ID`: https://mariadb.com/kb/en/replication-and-binary-log-server-system-variables/#server_id

`MYSQL_SLOW_QUERY_LOG`: https://mariadb.com/kb/en/library/server-system-variables/#slow_query_log

`MYSQL_SORT_BUFFER_SIZE`: https://mariadb.com/kb/en/library/server-system-variables/#sort_buffer_size

`MYSQL_TABLE_OPEN_CACHE`: https://mariadb.com/kb/en/library/server-system-variables/#table_open_cache

`MYSQL_TRANSACTION_ISOLATION`: https://mariadb.com/kb/en/library/set-transaction/

`TIMEZONE`: https://mariadb.com/kb/en/library/time-zones/

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to use this image


**docker**

```dockerfile
docker run -d --name=mariadb \
    -e MYSQL_ROOT_PASSWORD=<secretpassword> \
    -e MYSQL_DATABASE=<databasename> \
    -e MYSQL_USER=<username> \
    -e MYSQL_PASSWORD=<password> \
    -v /var/lib/mysql_data:/var/lib/mysql \
    dsuite/mariadb
```

**Don't want to enable remote access client:**  
Change the `MYSQL_STARTPARAMS` environment variables to: `--skip-networking --skip-host-cache --skip-name-resolve --debug-gdb`

```dockerfile
docker run -d --name=mariadb \
    -e MYSQL_ROOT_PASSWORD=<secretpassword> \
    -e MYSQL_DATABASE=<databasename> \
    -e MYSQL_USER=<username> \
    -e MYSQL_PASSWORD=<password> \
    -e MYSQL_STARTPARAMS='--skip-networking --skip-host-cache --skip-name-resolve --debug-gdb' \
    -v /var/lib/mysql_data:/var/lib/mysql \
    dsuite/mariadb
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Performance Tuning

Use [MySQLTuner][mysqltuner] to assist you with your MySQL configuration:

```dockerfile
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

