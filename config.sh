#!/bin/bash

echo Config
source /etc/sysconfig/grafana-server
cd /usr/share/grafana
CONFIG_DIR='/etc/dockerconf/grafana'
CONFIG_FILE='/etc/grafana/grafana.ini'
DB_FILE='/var/lib/grafana/grafana.db'
LINE='---------------------------'

if [[ ${CRUPT_PASS} == 'null' ]];
  then
    echo 'No set password: CRUPT_PASS'
  fi

CONFIG_DB=${CONFIG_DIR}/enc.db
if [[ -f ${CONFIG_DB} ]];
  then
    rm -f ${DB_FILE}
    openssl enc -aes-256-cbc -d -a -in ${CONFIG_DB} -out ${DB_FILE} -k ${CRUPT_PASS} || exit
    chown grafana.grafana ${DB_FILE} 
    rm -f ${CONFIG_DB} 
    CRUPT_PASS=''
  else
    echo 'No DB file '${CONFIG_DB}
    exit
  fi

if [[ ${ROOT_URL} == 'null' ]];
   then
     echo 'No set ROOT_URL'
     exit
   fi
sed -i 's#ROOT_URL#'"${ROOT_URL}"'#' ${CONFIG_FILE}
echo ${LINE}
echo 'cat '${CONFIG_FILE}
cat ${CONFIG_FILE}
echo ${LINE}

if [[ ${JSON} == 'null' ]];
  then
    echo 'No set json var: JSON'
    echo 'Start config default'
  else
    /usr/local/bin/json.sh &
  fi

GIT_CONFIG=${CONFIG_DIR}/grafana.ini
if [[ -f ${GIT_CONFIG} ]];
  then
    cat ${GIT_CONFIG} > ${CONFIG_FILE}
  else
   echo 'No config file '${GIT_CONFIG}
   exit
  fi

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
