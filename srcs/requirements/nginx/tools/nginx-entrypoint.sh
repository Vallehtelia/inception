#!/bin/bash
set -e

# Jos sertifikaattia ei ole, generoidaan se
if [ ! -f /etc/nginx/ssl/public_certificate.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/private.key \
        -out /etc/nginx/ssl/public_certificate.crt \
        -subj "/CN=${DOMAIN_NAME}"
fi

# Käynnistetään NGINX etuprosessina (daemon off pitää sen käynnissä)
exec nginx -g "daemon off;"