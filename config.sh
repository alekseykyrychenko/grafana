#!/bin/bash

echo Start Grafana
source /etc/sysconfig/grafana-server
cd /usr/share/grafana
CONFIG_DIR='/etc/dockerconf/grafana'
CONFIG_FILE='/etc/grafana/grafana.ini'
echo ${CONFIG_DIR}/grafana.ini > ${CONFIG_FILE}

sed -i 's//${ROOT_URL}/' ${CONFIG_FILE}

/usr/sbin/grafana-server    --config=${CONF_FILE}                                   \
                            --pidfile=${PID_FILE_DIR}/grafana-server.pid            \
                            --packaging=rpm                                         \
                            cfg:default.paths.logs=${LOG_DIR}                       \
                            cfg:default.paths.data=${DATA_DIR}                      \
                            cfg:default.paths.plugins=${PLUGINS_DIR}                \
                            cfg:default.paths.provisioning=${PROVISIONING_CFG_DIR}
