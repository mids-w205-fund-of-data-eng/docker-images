FROM cloudera/quickstart:5.7.0-0-beta
MAINTAINER Mark Mims <mark@digitalocean.com>

COPY docker-entrypoint /usr/bin/
COPY docker-quickstart /usr/bin/
RUN chmod +x /usr/bin/docker-*

ENTRYPOINT ["/usr/bin/docker-entrypoint"]
CMD ["/usr/bin/docker-quickstart"]
