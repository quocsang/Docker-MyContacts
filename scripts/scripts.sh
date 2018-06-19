#!/bin/bash
/opt/karaf/bin/start
/opt/karaf/bin/client -f /root/karaf_service.script
/opt/karaf/bin/stop