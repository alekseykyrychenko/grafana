#!/usr/bin/python2
# -*- coding: utf-8 -*-

from grafana_api.grafana_face import GrafanaFace
import json
import glob

grafana_api = GrafanaFace(auth=('admin', 'HG73gwe9e3rhel02herq0303h'),
                          host='localhost', port='3000', protocol='http')

grafana_user_id="1"
grafana_pass="sdfdfsdf34r5wr35th"

print("Set password")
grafana_api.admin.change_user_password(grafana_user_id, admin_pass)
