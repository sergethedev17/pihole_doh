#!/bin/bash

# exit when any command fails
set -e

# Clean up rubbish files
rm -rf /www/html/admin/.git

# Prepare DOH daemon
useradd -s /usr/sbin/nologin -r -M cloudflared
mv ./bin/cloudflared /usr/local/bin
chmod +x /usr/local/bin/cloudflared
cloudflared -v

chown cloudflared:cloudflared /usr/local/bin/cloudflared

mkdir -p /etc/s6/services/cloudflared
mv ./s6_services_cloudflared_run /etc/s6/services/cloudflared/run
chmod +rx /etc/s6/services/cloudflared/run



# Prepare Lighttpd SSL, if configured
mv ./lighttpd_external.conf.template /etc/lighttpd/external.conf.template
mv ./lighttpd-prep /etc/cont-init.d/lighttpd-prep
chmod 755 /etc/cont-init.d/lighttpd-prep
