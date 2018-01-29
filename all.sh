#!/bin/sh

for DOMAIN in $DOMAINS; do
	echo $DOMAIN

	for T in \
		${CSRROOT}_${DOMAIN}_full.$$ \
		${CSRROOT}_${DOMAIN}_chain.$$ \
		${CSRROOT}_${DOMAIN}.$$; do
		if test -f "$T"; then
			rm "$T";
		fi
	done

	./certbot-auto certonly \
	-d "$DOMAIN" \
	-d "www.$DOMAIN" \
	--noninteractive \
	--csr "$CSRROOT/${DOMAIN}.csr" \
	--manual --email "cert@${DOMAIN}" \
	--authenticator manual \
	--preferred-challenges http \
	--agree-tos \
	--manual-public-ip-logging-ok \
	--manual-auth-hook ./validation.sh \
	--fullchain-path "${CSRROOT}_${DOMAIN}_full.$$" \
	--chain-path "${CSRROOT}_${DOMAIN}_chain.$$" \
	--cert-path "${CSRROOT}_${DOMAIN}.$$"
	if test $? -eq 0; then
		mv "${CSRROOT}_${DOMAIN}.$$" "${CSRROOT}_${DOMAIN}"
		mv "${CSRROOT}_${DOMAIN}_full.$$" "${CSRROOT}_${DOMAIN}_full"
		mv "${CSRROOT}_${DOMAIN}_chain.$$" "${CSRROOT}_${DOMAIN}_chain"
	fi
done

