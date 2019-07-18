FROM dsuite/alpine-base:latest

# Install
RUN \
	# Print executed commands
	set -x \
    # Update repository indexes
    && apk update \
    # Create mysql group
    && addgroup -g 101 -S mysql \
    # Create mysql user
    && adduser -u 100 -D -S -s /bin/bash -G mysql mysql \
    # Install run dependencies
    && apk-install \
        libaio \
        libressl \
        libstdc++ \
        ncurses-libs \
        readline \
        pcre \
        xz \
        zlib \
    # Install build dependencies
    && apk-install \
        ##
        alpine-sdk \
        cmake \
        coreutils \
        ##
        bison \
        libaio-dev \
        libressl-dev \
        linux-headers \
        ncurses-dev \
        readline-dev \
        pcre-dev \
        xz-dev \
        zlib-dev

#
COPY tmp /tmp
 
#
RUN \
	# Print executed commands
	set -x \
    # cd to source folder
    && cd "/tmp/mariadb" \
    # Apply patches
    && for i in `ls -v /tmp/patch/*.patch`; do patch -p0 -i "${i}"; done

#
RUN \
	# Print executed commands
	set -x \
    # cd to source folder
    && cd "/tmp/mariadb" \
    # Build from source
    && cmake . \
        -DBUILD_CONFIG=mysql_release \
   		-DCMAKE_INSTALL_PREFIX=/usr \
   		-DSYSCONFDIR=/mysql/conf \
   		-DMYSQL_DATADIR=/mysql/db \
   		-DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock \
   		-DDEFAULT_CHARSET=utf8 \
   		-DDEFAULT_COLLATION=utf8_unicode_ci \
   		-DENABLED_LOCAL_INFILE=ON \
   		-DINSTALL_INFODIR=share/mysql/docs \
   		-DINSTALL_MANDIR=share/man \
   		-DINSTALL_PLUGINDIR=lib/mysql/plugin \
   		-DINSTALL_SCRIPTDIR=bin \
   		-DINSTALL_INCLUDEDIR=include/mysql \
   		-DINSTALL_DOCREADMEDIR=share/mysql \
   		-DINSTALL_SUPPORTFILESDIR=share/mysql \
   		-DINSTALL_MYSQLSHAREDIR=share/mysql \
   		-DINSTALL_DOCDIR=share/mysql/docs \
   		-DINSTALL_SHAREDIR=share/mysql \
   		-DWITH_READLINE=ON \
   		-DWITH_ZLIB=system \
   		-DWITH_SSL=system \
   		-DWITH_LIBWRAP=OFF \
   		-DWITH_JEMALLOC=no \
   		-DWITH_EXTRA_CHARSETS=complex \
   		-DWITH_EMBEDDED_SERVER=ON \
   		-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
   		-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
   		-DWITH_INNOBASE_STORAGE_ENGINE=1 \
   		-DWITH_PARTITION_STORAGE_ENGINE=1 \
   		-DPLUGIN_TOKUDB=NO \
   		-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
   		-DWITHOUT_FEDERATED_STORAGE_ENGINE=1 \
   		-DWITHOUT_PBXT_STORAGE_ENGINE=1 \
    && make -j "$(nproc)" \
    && make install \
	# test
	#&& make test \
	# Clear apk's cache
	&& apk-cleanup
