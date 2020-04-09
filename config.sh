#!/bin/bash

echo Config
source /etc/sysconfig/grafana-server
cd /usr/share/grafana
CONFIG_DIR='/etc/dockerconf/grafana'
CONFIG_FILE='/etc/grafana/grafana.ini'
LINE='---------------------------'
cat ${CONFIG_DIR}/grafana.ini > ${CONFIG_FILE}

if [[ ${ROOT_URL} == 'null' ]];
   then
     echo 'No set ROOT_URL'
     sleep 20
     exit
   fi
sed -i 's#ROOT_URL#'"${ROOT_URL}"'#' ${CONFIG_FILE}
echo ${LINE}
echo 'cat '${CONFIG_FILE}
cat ${CONFIG_FILE}
echo ${LINE}

echo Start Grafana
/usr/sbin/grafana-server    --config=${CONF_FILE}                                   \
                            --pidfile=${PID_FILE_DIR}/grafana-server.pid            \
                            --packaging=rpm                                         \
                            cfg:default.paths.logs=${LOG_DIR}                       \
                            cfg:default.paths.data=${DATA_DIR}                      \
                            cfg:default.paths.plugins=${PLUGINS_DIR}                \
                            cfg:default.paths.provisioning=${PROVISIONING_CFG_DIR}
