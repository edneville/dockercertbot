FROM debian
MAINTAINER "Ed"
COPY sources.list /etc/apt/
RUN mkdir -p /usr/local/certbot
COPY certbot-auto all.sh validation.sh /usr/local/certbot/
RUN chmod 755 /usr/local/certbot/certbot-auto
