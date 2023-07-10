#!/bin/sh
/usr/bin/supervisord -c "/etc/supervisord.conf" && nginx -g "daemon off;"
