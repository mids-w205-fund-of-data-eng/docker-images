FROM zhicwu/presto:latest
MAINTAINER Mark Mims <mark.mims@gmail.com>

ENV PRESTO_HOME=/presto

RUN ln -s ${PRESTO_HOME}/presto-cli*executable.jar /usr/bin/presto

RUN mkdir -p ${PRESTO_HOME}/etc/catalog
COPY etc/config.properties ${PRESTO_HOME}/etc/
COPY etc/jvm.config ${PRESTO_HOME}/etc/
COPY etc/log.properties ${PRESTO_HOME}/etc/
COPY etc/node.properties ${PRESTO_HOME}/etc/
COPY etc/catalog/jmx.properties ${PRESTO_HOME}/etc/catalog/

RUN mkdir -p ${PRESTO_HOME}/etc/templates
COPY etc/catalog/hive.properties ${PRESTO_HOME}/etc/templates/

COPY docker-entrypoint /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint
ENTRYPOINT ["/usr/bin/docker-entrypoint"]
CMD ["./bin/launcher", "run"]
