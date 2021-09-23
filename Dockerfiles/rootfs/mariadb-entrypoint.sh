#!/usr/bin/env bash

# shellcheck disable=SC1091
# shellcheck disable=SC2086

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu
# avoid globbing (expansion of *).
set -f

# Add libraries
source /usr/local/lib/bash-logger.sh
source /usr/local/lib/persist-env.sh

# Default values
export MYSQL_DATA_DIR=${MYSQL_DATA_DIR:=${MARIADB_DATA_DIR:='/mariadb/data/'}}
export MYSQL_INSTALL_PARAMS=${MYSQL_INSTALL_PARAMS:=''}
export MYSQL_STARTCMD=${MYSQL_STARTCMD:='/usr/bin/mysqld'}
export MYSQL_STARTPARAMS=${MYSQL_STARTPARAMS:='--skip-host-cache --skip-name-resolve --debug-gdb'}
export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:=''}
export MYSQL_ALLOW_EMPTY_PASSWORD=${MYSQL_ALLOW_EMPTY_PASSWORD:=false}
export MYSQL_RANDOM_ROOT_PASSWORD=${MYSQL_RANDOM_ROOT_PASSWORD:=false}
export MYSQL_DATABASE=${MYSQL_DATABASE:=''}
export MYSQL_USER=${MYSQL_USER:=''}
export MYSQL_PASSWORD=${MYSQL_PASSWORD:=''}

#
_check_config() {
	toRun=( mysqld --verbose --help --log-bin-index="$(mktemp -u)" )
	if ! errors="$("${toRun[@]}" 2>&1 >/dev/null)"; then
		ERROR "mysqld failed while attempting to check config"
        ERROR "command was: \"${toRun[*]}\""
		$errors | ERROR
		exit 1
	fi
}

# Fetch value from server config
# We use mysqld --verbose --help instead of my_print_defaults because the
# latter only show values present in config files, and not server defaults
_get_config() {
	local conf="$1"; shift
	mysqld --verbose --help --log-bin-index="$(mktemp -u)" 2>/dev/null \
		| awk '$1 == "'"$conf"'" && /^[^ \t]/ { sub(/^[^ \t]+[ \t]+/, ""); print; exit }'
}

# If the MYSQL_DATA_DIR doesn't exist, this mean
# that we perform the first install.
if [[ -z "$(ls -A ${MYSQL_DATA_DIR})" ]]; then

    # First, check for root password
    if [[ -z "${MYSQL_ROOT_PASSWORD}" ]] && [[ "${MYSQL_RANDOM_ROOT_PASSWORD}" = 'false' ]] && [[ "${MYSQL_ALLOW_EMPTY_PASSWORD}" = 'false' ]]; then
        ERROR ''
        ERROR ''
        ERROR 'Error: database is uninitialized and password option is not specified'
        ERROR 'You need to specify one of MYSQL_ROOT_PASSWORD, MYSQL_RANDOM_ROOT_PASSWORD or MYSQL_ALLOW_EMPTY_PASSWORD'
        ERROR ''
        exit 1
    fi

    # By default, use the root password defined by the user
    # or use a random password if MYSQL_RANDOM_ROOT_PASSWORD is true
    # or use an empty password if MYSQL_ALLOW_EMPTY_PASSWORD is true
    if [[ -z "${MYSQL_ROOT_PASSWORD}" ]]; then
        # random password
        if [[ "${MYSQL_RANDOM_ROOT_PASSWORD}" = 'true' ]]; then
            MYSQL_ROOT_PASSWORD="$(date +%s | sha256sum | md5sum | base64 | head -c 16)"
            WARNING "GENERATED ROOT PASSWORD: ${MYSQL_ROOT_PASSWORD}"
        # Empty password
        elif [[ "${MYSQL_ALLOW_EMPTY_PASSWORD}" = 'true' ]]; then
            MYSQL_ROOT_PASSWORD="''"
        fi
    fi

    # Create the MYSQL_DATA_DIR and give full access to mariadb user.
    mkdir -p "${MYSQL_DATA_DIR}"
    chown -R ${MARIADB_USER}:${MARIADB_GROUP} "${MYSQL_DATA_DIR}"

    # Get tmpdir from config file
    TMPDIR=$(grep "^tmpdir" ${MARIADB_CONFIG_DIR}/mariadb.cnf | awk -F"=" '{print $2}' | xargs)
    if [[ -z "${TMPDIR}" ]]; then TMPDIR="/tmp"; fi

    # Make sure tmpdir folder exist
    if [[ ! "${TMPDIR}" = "/tmp" ]]; then
        mkdir -p ${TMPDIR}
        chown -R ${MARIADB_USER}:${MARIADB_GROUP} ${TMPDIR}
    fi

    NOTICE ''
    NOTICE "An empty or uninitialized MariaDB volume is detected in ${MYSQL_DATA_DIR}"
    NOTICE ''
    NOTICE 'Installing MariaDB ...'
    NOTICE ''

    # List of args to use to install the database
    declare -a installArgs
    installArgs=(  --user="${MARIADB_USER}" )
    installArgs+=( --basedir=/usr )
    installArgs+=( --datadir="${MYSQL_DATA_DIR}" )
    installArgs+=( --rpm )
    installArgs+=( --cross-bootstrap )
    if { mysql_install_db --help || :; } | grep -q -- '--auth-root-authentication-method'; then
        # beginning in 10.4.3, install_db uses "socket" which only allows system user root to connect, switch back to "normal" to allow mysql root without a password
        # see https://github.com/MariaDB/server/commit/b9f3f06857ac6f9105dc65caae19782f09b47fb3
        # (this flag doesn't exist in 10.0 and below)
        installArgs+=( --auth-root-authentication-method=normal )
    fi
    installArgs+=( --defaults-file=${MARIADB_CONFIG_DIR}/mariadb.cnf )

    # It's time to initialize the database
    NOTICE ''
    NOTICE 'Initializing database ...'
    NOTICE ''
    NOTICE 'mysql_install_db'
    for i in "${!installArgs[@]}"; do NOTICE "    ${installArgs[$i]}"; done
    NOTICE ''

    mysql_install_db "${installArgs[@]}"

    NOTICE ''
    NOTICE 'Database initialized'
    NOTICE ''

    # Init file used at startup
    INIT_FILE="${TMPDIR}/mariadb-boot.sql"

    # Create root user
    echo "
    USE mysql;
    SET @@SESSION.SQL_LOG_BIN=0;
    DELETE FROM mysql.user WHERE user NOT IN ('mysql.sys', 'mariadb.sys', 'mysqlxsys', 'root') OR host NOT IN ('localhost') ;
    GRANT ALL ON *.* TO 'root'@'%' identified by '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
    GRANT ALL ON *.* TO 'root'@'localhost' identified by '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
    FLUSH PRIVILEGES;" >| ${INIT_FILE}

    # Remove test database
    echo "
    DROP DATABASE IF EXISTS test;" >> ${INIT_FILE}

    # Create database
    if [[ -n "${MYSQL_DATABASE}" ]]; then
        NOTICE ''
        NOTICE "Preparing database ${MYSQL_DATABASE} ..."
        echo "
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> ${INIT_FILE}
        # Add user to databse
        if [[ -n "${MYSQL_USER}" ]] && [[ -n "${MYSQL_PASSWORD}" ]]; then
            echo "
            GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
            FLUSH PRIVILEGES;" >> ${INIT_FILE}
        fi
        NOTICE ''
    fi

    # Create user database
    if [[ -n "${MYSQL_USER}" ]] && [[ -n "${MYSQL_PASSWORD}" ]] && [[ -z "${MYSQL_DATABASE}" ]]; then
        NOTICE ''
        NOTICE "Preparing user database ${MYSQL_USER} ..."
        echo "
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_USER}\`;
        GRANT ALL PRIVILEGES ON \`${MYSQL_USER}\`.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        FLUSH PRIVILEGES;" >> ${INIT_FILE}
        NOTICE ''
    fi

    # Update start command
    MYSQL_STARTCMD="${MYSQL_STARTCMD} --init-file=${INIT_FILE}"

    #
    cat ${INIT_FILE} | DEBUG
else
    NOTICE ''
    NOTICE "Found existing MariaDB volume in ${MYSQL_DATA_DIR}"
    NOTICE ''

    # Give full access to mariadb user.
    chown -R ${MARIADB_USER}:${MARIADB_GROUP} "${MYSQL_DATA_DIR}"

    # Get tmpdir from config
    TMPDIR=$(_get_config "tmpdir")
    if [[ -z "${TMPDIR}" ]]; then TMPDIR="/tmp"; fi

    # Make sure tmpdir folder exist
    if [[ ! "${TMPDIR}" = "/tmp" ]]; then
        mkdir -p ${TMPDIR}
        chown -R ${MARIADB_USER}:${MARIADB_GROUP} ${TMPDIR}
    fi

    # Upgrading database
    if [[ -n "${MYSQL_ROOT_PASSWORD}" ]]; then

        declare -a upgradeArgs
        upgradeArgs=( --user=root )
        upgradeArgs+=( --password="${MYSQL_ROOT_PASSWORD}" )
        upgradeArgs+=( --socket=/var/run/mariadb/mariadb.sock )

        NOTICE ''
        NOTICE 'Upgrade MariaDB after it starts'
        NOTICE ''
        NOTICE '    mysql_upgrade --user=root --password=******'
        NOTICE ''
    fi
fi

# Make sure the backup file can be excuted
chmod +x /etc/periodic/daily_3am/db_backup

# User start parameteres
userstartArgs=(${MYSQL_STARTPARAMS})
# Set start parameters
declare -a startArgs
startArgs=( --user="${MARIADB_USER}" )
startArgs+=( --basedir=/usr )
startArgs+=( --datadir="${MYSQL_DATA_DIR}" )
for i in "${!userstartArgs[@]}"; do
startArgs+=( ${userstartArgs[i]} )
done
startArgs+=( --plugin-dir=/usr/lib/mysql/ )
startArgs+=( --pid-file=/var/run/mariadb/mariadb.pid )
startArgs+=( --socket=/var/run/mariadb/mariadb.sock )

# Let's go and start MariaDB
NOTICE ''
NOTICE 'Starting MariaDB'
NOTICE ''
NOTICE "    ${MYSQL_STARTCMD}"
for i in "${!startArgs[@]}"; do
    NOTICE "        ${startArgs[$i]}"
done
NOTICE ''

exec ${MYSQL_STARTCMD} "${startArgs[@]}"
