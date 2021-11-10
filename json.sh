#!/bin/bash

echo 'Start "'${1}'"'

su -s /bin/bash grafana -c "${1}" > /dev/null &

VAR=0
while [[ -z $(curl -Is http://localhost:3000/login|head -n 1|grep ' 200 OK') ]]; 
     do 
           echo -n -; 
           sleep 1;
           VAR=$((${VAR}+1))
           #if [[ ${VAR} > 20 ]]; then exit; fi
     done && echo 'Start create-dashboard.py' &&\
python /etc/dockerconf/grafana/create-dashboard.py       
                            
