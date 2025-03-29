#!/bin/bash
set -e

# Make sure certificate exists
if [ ! -f /etc/nginx/ssl/public_certificate.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/private.key \
        -out /etc/nginx/ssl/public_certificate.crt \
        -subj "/CN=${DOMAIN_NAME}"
fi

exec nginx -g "daemon off;"
