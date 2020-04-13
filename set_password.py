#!/usr/bin/python2
# -*- coding: utf-8 -*-

from grafana_api.grafana_face import GrafanaFace
import glob
import sys

grafana_api = GrafanaFace(auth=('admin', 'HG73gwe9e3rhel02herq0303h'),
                          host='localhost', port='3000', protocol='http')

grafana_user_id=str(sys.argv[1])
grafana_pass=str(sys.argv[2])

print("Set password: " + grafana_api.users.get_user(grafana_user_id))
grafana_api.admin.change_user_password(grafana_user_id, grafana_pass)
