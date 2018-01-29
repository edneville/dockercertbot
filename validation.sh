#!/bin/sh

CERTBOT_DOMAIN=`echo $CERTBOT_DOMAIN | sed -s 's/^www.//g;'`

WWWROOT="$WWWROOT.${CERTBOT_DOMAIN}"

if test $CERTBOT_DOMAIN = "usenix.org.uk"; then
	WWWROOT="/var/www/sites/wiki.s5h.net"
fi

WWWPATH="${WWWROOT}/.well-known/acme-challenge/${CERTBOT_TOKEN}"

echo "${CERTBOT_VALIDATION}" >"$WWWPATH"
