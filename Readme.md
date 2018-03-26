# MariaDB

This is a docker image for [MariaDB][MariaDB] database running on [Alpine container][alpine-runit] with [runit][runit] process supervisor.

## Volumes
- /etc/mysql
- /var/lib/mysql
- /backup/mysql

## Ports
- 3306

## Available environment variables

Name                                | Default value                     | Info
------------------------------------|-----------------------------------|-------------------
MYSQL_ROOT_PASSWORD                 | [empty]                           | sets a root password
MYSQL_ALLOW_EMPTY_PASSWORD          | `false`                           | Enable empty password (true or false)
MYSQL_RANDOM_ROOT_PASSWORD          | `false`                           | Generate random root password (true or false)
MYSQL_DATABASE                      | [empty]                           | creates a database as provided by input
MYSQL_USER                          | [empty]                           | creates a user with owner permissions over said database
MYSQL_PASSWORD                      | [empty]                           | changes password of the provided user (not root)
MYSQL_DATA_DIR                      | `/var/lib/mysql/`                 | Change mysql default directory
MYSQL_STARTCMD                      | `/usr/bin/mysqld`                 | Default start command
MYSQL_STARTPARAMS                   | `--skip-host-cache --skip-name-resolve --debug-gdb` | Default start parameters
DEFAULT_CHARACTER_SET               | `utf8`
CHARACTER_SET_SERVER                | `utf8`
COLLATION_SERVER                    | `utf8_general_ci`
TIME_ZONE                           | `+00:00`
KEY_BUFFER_SIZE                     | `16M`
MAX_ALLOWED_PACKET                  | `1M`
TABLE_OPEN_CACHE                    | `64`
SORT_BUFFER_SIZE                    | `512K`
NET_BUFFER_SIZE                     | `8K`
READ_BUFFER_SIZE                    | `256K`
READ_RND_BUFFER_SIZE                | `512K`
MYISAM_SORT_BUFFER_SIZE             | `8M`
BIND_ADRESS                         | `0.0.0.0`
LOG_BIN                             | `mysql-bin`
BINLOG_FORMAT                       | `mixed`
SERVER_ID                           | `1`
INNODB_DATA_FILE_PATH               | `ibdata1:10M:autoextend`
INNODB_BUFFER_POOL_SIZE             | `16M`
INNODB_LOG_FILE_SIZE                | `5M`
INNODB_LOG_BUFFER_SIZE              | `8M`
INNODB_EMPTY_FREE_LIST_ALGORITHM    | `legacy` (Removed in 10.3)
INNODB_FLUSH_LOG_AT_TRX_COMMIT      | `1`
INNODB_LOCK_WAIT_TIMEOUT            | `50`
INNODB_USE_NATIVE_AIO               | `1`
INNODB_LARGE_PREFIX                 | `OFF`` (Removed in 10.3)
INNODB_FILE_FORMAT                  | `Antelope` (10.1) `Barracuda` (10.2) (Removed in 10.3)
INNODB_FILE_PER_TABLE               | `ON`
MAX_ALLOWED_PACKET                  | `16M`
KEY_BUFFER_SIZE                     | `20M`
SORT_BUFFER_SIZE                    | `20M`
READ_BUFFER                         | `2M`
WRITE_BUFFER                        | `2M`
RETENTION_DAYS                      | `14`


## How to use this image

Build :

```Dockerfile
docker build -t craftdock/mariadb .
```

Typical usage:

```Dockerfile
docker run -d --name=mariadb \
        -e MYSQL_ROOT_PASSWORD=<secretpassword> \
        -e MYSQL_DATABASE=<databasename> \
        -e MYSQL_USER=<username> \
        -e MYSQL_PASSWORD=<password> \
        -v $(PWD)/mariadb/:/var/lib/mysql \
            craftdock/mariadb
```

Don't want to enable remote access client.
Change the MYSQL_STARTPARAMS environment variables to `--skip-networking --skip-host-cache --skip-name-resolve --debug-gdb`

```Dockerfile
docker run -d --name=mariadb \
        -p 3306:3306 \
        -e MYSQL_ROOT_PASSWORD=<secretpassword> \
        -e MYSQL_DATABASE=<databasename> \
        -e MYSQL_USER=<username> \
        -e MYSQL_PASSWORD=<password> \
        -e MYSQL_STARTPARAMS='--skip-networking --skip-host-cache --skip-name-resolve --debug-gdb' \
        -v $(PWD)/mariadb/:/var/lib/mysql \
            craftdock/mariadb
```

To start or stop MariDB, get an sh command prompt inside the container:

```powershell
docker exec -it mariadb sh

# Start mariadb
runit service mariadb start
# Stop mariadb
runit service mariadb stop
# Restart mariadb
runit service mariadb restart
# Status of mariadb
runit service mariadb status

# Stop the container
runit stop
```

[alpine]: http://alpinelinux.org/
[runit]: http://smarden.org/runit/
[MariaDB]: https://mariadb.org/
[alpine-runit]: https://hub.docker.com/r/craftdock/alpine-runit/
