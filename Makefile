CONTAINER=certbot
DOMAINS="s5h.net usenix.org.uk"
WWWROOT="/var/www/sites/www"
CSRROOT="/var/www/sites/"

all: build run remove

run:
	docker run --rm \
	-v /home/ed/services/ssl:/home/ed/services/ssl \
	-e "DOMAINS=$(DOMAINS)" \
	-e "WWWROOT=$(WWWROOT)" \
	-e "CSRROOT=$(CSRROOT)" \
	-v /var/www/sites/www.s5h.net/.well-known:/var/www/sites/www.s5h.net/.well-known \
	$(CONTAINER) /bin/bash -c "cd /usr/local/certbot && sh ./all.sh"
	/usr/sbin/apachectl configtest && /usr/sbin/apachectl graceful

build:
	-docker rm -f $(CONTAINER)
	docker build --tag $(CONTAINER) .
	
get:
	wget -O certbot-auto https://dl.eff.org/certbot-auto

