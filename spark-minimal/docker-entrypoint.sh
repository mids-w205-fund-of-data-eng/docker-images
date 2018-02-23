#!/bin/bash
set -eo pipefail
shopt -s nullglob

# if command starts with an option, prepend spark-shell
if [ "${1:0:1}" = '-' ]; then
	set -- spark-shell "$@"
fi

if [ ! -z "$HADOOP_NAMENODE" ]; then
  cp $SPARK_TEMPLATE_PATH/*-site.xml $SPARK_CONF_PATH/
  sed -i "s/myhdfs/${HADOOP_NAMENODE}/" $SPARK_CONF_PATH/core-site.xml
fi

echo
echo 'Config process done. Ready for startup.'
echo 

exec "$@"
