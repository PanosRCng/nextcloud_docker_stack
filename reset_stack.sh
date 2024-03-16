#!/bin/bash

[ "$UID" -eq 0 ] || { echo "this operation must be run as root."; exit 1;}


find stack_data -depth ! \( -name 'stack_data' -o -name 'db_data' -o -name 'nextcloud_data' -o -name 'app_data' -o -name 'datadir' -o -name 'redis_data' -o -name 'redis-session.ini' -o -name 'nginx_data' -o -name 'nginx.conf' -o -name '.gitkeep' \) \
 -type d,f -exec rm -rvf {} +



