#!/usr/bin/python2
# -*- coding: utf-8 -*-

from grafana_api.grafana_face import GrafanaFace
import json
import glob

grafana_api = GrafanaFace(auth=('admin', 'HG73gwe9e3rhel02herq0303h'),
                          host='localhost', port='3000', protocol='http')

with open("/etc/conf/system.config") as system_file:
  try:
  system_config = json.load(system_file)
  print ("Org: " + system_config["org"])
  except:
    print ("Error system file")

for ls_file in glob.glob("/etc/conf/*.json"):
  print(ls_file)
  with open(ls_file) as json_file:
    dashboard = json.load(json_file)
    dashboard["id"] = None
    dashboard["uid"] = None
    dashboard["version"] = 0
    post_json = {
      "dashboard": dashboard,
      "folderId": 0,
      "overwrite": False
    }
    try:
      print (grafana_api.dashboard.update_dashboard(post_json))
    except:
      print ("File: " + ls_file + " not consistent")
