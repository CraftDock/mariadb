# Example MariaDB config file for medium systems.
#
# This is for a system with little memory (32M - 64M) where MariaDB plays
# an important part, or systems up to 128M where MariaDB is used together with
# other programs (such as a web server)
#
# MariaDB programs look for option files in a set of
# locations which depend on the deployment platform.
# You can copy this option file to one of those
# locations. For information about these locations, do:
# 'my_print_defaults --help' and see what is printed under
# Default options are read from the following files in the given order:
# More information at: http://dev.mysql.com/doc/mysql/en/option-files.html
#
# In this file, you can use all long options that a program supports.
# If you want to know which options a program supports, run the program
# with the "--help" option.

# The following options will be passed to all MariaDB clients
[client]
#password	= your_password
port		= 3306
socket		= /run/mysqld/mysqld.sock
default-character-set = {{DEFAULT_CHARACTER_SET}}

# Here follows entries for some specific programs

# The MariaDB server
[mysqld]
port		= 3306
socket		= /run/mysqld/mysqld.sock
character-set-server = {{CHARACTER_SET_SERVER}}
collation-server = {{COLLATION_SERVER}}
default-time-zone = {{TIME_ZONE}}
skip-external-locking
key_buffer_size = {{KEY_BUFFER_SIZE}}
max_allowed_packet = {{MAX_ALLOWED_PACKET}}
table_open_cache = {{TABLE_OPEN_CACHE}}
sort_buffer_size = {{SORT_BUFFER_SIZE}}
net_buffer_length = {{NET_BUFFER_SIZE}}
read_buffer_size = {{READ_BUFFER_SIZE}}
read_rnd_buffer_size = {{READ_RND_BUFFER_SIZE}}
myisam_sort_buffer_size = {{MYISAM_SORT_BUFFER_SIZE}}

# Point the following paths to different dedicated disks
tmpdir		= /tmp/

# Don't listen on a TCP/IP port at all. This can be a security enhancement,
# if all processes that need to connect to mysqld run on the same host.
# All interaction with mysqld must be made via Unix sockets or named pipes.
# Note that using this option without enabling named pipes on Windows
# (via the "enable-named-pipe" option) will render mysqld useless!
#
#skip-networking
#skip-name-resolve
bind-address = {{BIND_ADRESS}}

# Replication Master Server (default)
# binary logging is required for replication
#log-bin = {{LOG_BIN}}

# binary logging format - mixed recommended
binlog_format = {{BINLOG_FORMAT}}

# required unique id between 1 and 2^32 - 1
# defaults to 1 if master-host is not set
# but will not function as a master if omitted
server-id	= {{SERVER_ID}}

# Replication Slave (comment out master section to use this)
#
# To configure this host as a replication slave, you can choose between
# two methods :
#
# 1) Use the CHANGE MASTER TO command (fully described in our manual) -
#    the syntax is:
#
#    CHANGE MASTER TO MASTER_HOST=<host>, MASTER_PORT=<port>,
#    MASTER_USER=<user>, MASTER_PASSWORD=<password> ;
#
#    where you replace <host>, <user>, <password> by quoted strings and
#    <port> by the master's port number (3306 by default).
#
#    Example:
#
#    CHANGE MASTER TO MASTER_HOST='125.564.12.1', MASTER_PORT=3306,
#    MASTER_USER='joe', MASTER_PASSWORD='secret';
#
# OR
#
# 2) Set the variables below. However, in case you choose this method, then
#    start replication for the first time (even unsuccessfully, for example
#    if you mistyped the password in master-password and the slave fails to
#    connect), the slave will create a master.info file, and any later
#    change in this file to the variables' values below will be ignored and
#    overridden by the content of the master.info file, unless you shutdown
#    the slave server, delete master.info and restart the slaver server.
#    For that reason, you may want to leave the lines below untouched
#    (commented) and instead use CHANGE MASTER TO (see above)
#
# required unique id between 2 and 2^32 - 1
# (and different from the master)
# defaults to 2 if master-host is set
# but will not function as a slave if omitted
#server-id       = 2
#
# The replication master for this slave - required
#master-host     =   <hostname>
#
# The username the slave will use for authentication when connecting
# to the master - required
#master-user     =   <username>
#
# The password the slave will authenticate with when connecting to
# the master - required
#master-password =   <password>
#
# The port the master is listening on.
# optional - defaults to 3306
#master-port     =  <port>
#
# binary logging - not required for slaves, but recommended
#log-bin=mysql-bin

# Uncomment the following if you are using InnoDB tables
innodb_data_home_dir = /var/lib/mysql
innodb_data_file_path = {{INNODB_DATA_FILE_PATH}}
innodb_log_group_home_dir = /var/lib/mysql
# You can set .._buffer_pool_size up to 50 - 80 %
# of RAM but beware of setting memory usage too high
innodb_buffer_pool_size = {{INNODB_BUFFER_POOL_SIZE}}
#innodb_additional_mem_pool_size = 2M
# Set .._log_file_size to 25 % of buffer pool size
innodb_log_file_size = {{INNODB_LOG_FILE_SIZE}}
innodb_log_buffer_size = {{INNODB_LOG_BUFFER_SIZE}}
innodb_flush_log_at_trx_commit = {{INNODB_FLUSH_LOG_AT_TRX_COMMIT}}
innodb_lock_wait_timeout = {{INNODB_LOCK_WAIT_TIMEOUT}}
innodb_use_native_aio = {{INNODB_USE_NATIVE_AIO}}
innodb_default_row_format = {{INNODB_DEFAULT_ROW_FORMAT}}
innodb_file_per_table = {{INNODB_FILE_PER_TABLE}}

[mysqldump]
quick
quote-names
max_allowed_packet = {{MAX_ALLOWED_PACKET}}

[mysql]
no-auto-rehash
# Remove the next comment character if you are not familiar with SQL
#safe-updates

[myisamchk]
key_buffer_size = {{KEY_BUFFER_SIZE}}
sort_buffer_size = {{SORT_BUFFER_SIZE}}
read_buffer = {{READ_BUFFER}}
write_buffer = {{WRITE_BUFFER}}

[mysqlhotcopy]
interactive-timeout

!includedir /etc/mysql/conf.d/
