#!/usr/bin/python2
# -*- coding: utf-8 -*-

from grafana_api.grafana_face import GrafanaFace
import json

grafana_api = GrafanaFace(auth='_______',
                          host='localhost', port='3000', protocol='https', url_path_prefix='monitoring/')

with open('/etc/conf/config.json') as json_file:
  dashboard = json.load(json_file)
  print (grafana_api.dashboard.update_dashboard(dashboard))
