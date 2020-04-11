#!/bin/bash

echo 'Import dashboard '${JSON}

su -s /bin/bash grafana -c "/usr/sbin/grafana-server    --config=${CONF_FILE}       \
                            --pidfile=${PID_FILE_DIR}/grafana-server.pid            \
                            --packaging=rpm                                         \
                            cfg:default.paths.logs=${LOG_DIR}                       \
                            cfg:default.paths.data=${DATA_DIR}                      \
                            cfg:default.paths.plugins=${PLUGINS_DIR}                \
                            cfg:default.paths.provisioning=${PROVISIONING_CFG_DIR}" &&\
      while [[ -z $(curl -Is http://localhost:3000/logind|head -n 1|grep ' 200 OK') ]]; 
        do 
           echo -n -; sleep 1; 
        done &&\
     python /etc/dockerconf/grafana/create-dashboard.py
kill $(cat /var/run/grafana/grafana-server.pid)        
                            
