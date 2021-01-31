#!/bin/bash

# exit when any command fails
set -e

useradd -s /usr/sbin/nologin -r -M cloudflared
mv ./bin/cloudflared /usr/local/bin
chmod +x /usr/local/bin/cloudflared
cloudflared -v

chown cloudflared:cloudflared /usr/local/bin/cloudflared

mkdir -p /etc/s6/services/cloudflared
mv ./s6_services_cloudflared_run /etc/s6/services/cloudflared/run
chmod +x /etc/s6/services/cloudflared/run
