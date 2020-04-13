#!/usr/bin/python2
# -*- coding: utf-8 -*-

from grafana_api.grafana_face import GrafanaFace
import json
import glob

grafana_api = GrafanaFace(auth=('admin', 'HG73gwe9e3rhel02herq0303h'),
                          host='localhost', port='3000', protocol='http')

for ls_file in glob.glob("/etc/conf/*.json"):
  print(ls_file)
  with open(ls_file) as json_file:
    dashboard = json.load(json_file)
    try:
      print (grafana_api.dashboard.update_dashboard(dashboard))
    except:
      print ("File: " + ls_file + "not consistent")
