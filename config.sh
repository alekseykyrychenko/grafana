#!/bin/bash

echo Config
source /etc/sysconfig/grafana-server
cd /usr/share/grafana
CONFIG_DIR='/etc/dockerconf/grafana'
CONFIG_FILE='/etc/grafana/grafana.ini'
CONFIG_DB='/etc/grafana/'
SLEEP='20'
LINE='---------------------------'
GIT_CONFIG=${CONFIG_DIR}/grafana.ini
if [[ -f ${GIT_CONFIG} ]];
  then
    cat ${GIT_CONFIG} > ${CONFIG_FILE}
  else
   echo 'No config file '${GIT_CONFIG}
   sleep ${SLEEP}
   exit
  fi

if [[ ${ROOT_URL} == 'null' ]];
   then
     echo 'No set ROOT_URL'
     sleep ${SLEEP}
     exit
   fi
sed -i 's#ROOT_URL#'"${ROOT_URL}"'#' ${CONFIG_FILE}
echo ${LINE}
echo 'cat '${CONFIG_FILE}
cat ${CONFIG_FILE}
echo ${LINE}

echo Start Grafana
mkdir /var/run/grafana
chown grafana.grafana /var/run/grafana
su -s /bin/bash grafana -c "/usr/sbin/grafana-server    --config=${CONF_FILE}       \
                            --pidfile=${PID_FILE_DIR}/grafana-server.pid            \
                            --packaging=rpm                                         \
                            cfg:default.paths.logs=${LOG_DIR}                       \
                            cfg:default.paths.data=${DATA_DIR}                      \
                            cfg:default.paths.plugins=${PLUGINS_DIR}                \
                            cfg:default.paths.provisioning=${PROVISIONING_CFG_DIR}"
