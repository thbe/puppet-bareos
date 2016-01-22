#! /bin/sh
#
# Populate database schema for Bareos
#

# Stop on error
set -e

# Set path
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin

# Set MySQL parameter
MYSQL_COMMAND=$(which mysql)
MYSQL_USER="root"
MYSQL_PASSWORD=${1:-0nly4install}

# Define schema
SCHEMA_BAREOS="/usr/lib/bareos/scripts/ddl/creates/mysql.sql"

# Populate Bareos schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_bareos ]; then
  ${MYSQL_COMMAND} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} bareos < ${SCHEMA_BAREOS}
  if [ ${?} -eq 0 ]; then
    echo "Bareos database schema created" > /etc/sysconfig/mysqldb_bareos
  else
    echo "Can not deploy Bareos schema"; exit 1
  fi
fi
