#!/bin/sh
/usr/bin/supervisord -c "/etc/supervisord.conf" && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile