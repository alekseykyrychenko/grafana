#!/bin/bash

echo 'Start "'${1}'"'

su -s /bin/bash grafana -c "${1}" > /dev/null &&\
      while [[ -z $(curl -Is http://localhost:3000/login|head -n 1|grep ' 200 OK') ]]; 
        do 
           echo -n -; sleep 1; 
        done && echo 'Start create-dashboard.py' &&\
     python /etc/dockerconf/grafana/create-dashboard.py
kill $(cat /var/run/grafana/grafana-server.pid)        
                            
