FROM debian
MAINTAINER "Ed"
RUN mkdir -p /usr/local/certbot
COPY certbot-auto all.sh validation.sh /usr/local/certbot/
RUN chmod 755 /usr/local/certbot/certbot-auto
