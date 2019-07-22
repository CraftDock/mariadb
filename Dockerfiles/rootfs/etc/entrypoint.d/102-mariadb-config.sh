#!/usr/bin/env bash

# Generate mariadb config file from template
[ -f /etc/entrypoint.d/mariadb.cnf/setup ] && (chmod +x /etc/entrypoint.d/mariadb/setup; /etc/entrypoint.d/mariadb.cnf/setup)
