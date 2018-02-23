FROM ubuntu:16.04
MAINTAINER Mark Mims <mark@digitalocean.com>

#ENV SPARK_VERSION        2.2.0
#ENV SPARK_HADOOP_VERSION 2.6

#ENV PATH $SPARK_HOME/bin:$PATH

#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
#&& apt-get update \
#&& apt-get upgrade -y \
#&& apt-get install -y software-properties-common \
#&& add-apt-repository -y ppa:webupd8team/java \
#&& apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
#&& apt-get update \
#&& apt-get install -y \
    #curl \
    #dnsutils \
    #oracle-java8-installer \
#&& apt-get purge -y software-properties-common \
#&& apt-get autoremove -y \
#&& curl -OL http://www-us.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION.tgz \
#&& tar xf spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION.tgz \
#&& rm spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION.tgz
RUN apt-get -qq update \
  && apt-get -qq upgrade -y \
  && apt-get install -y \
      curl \
      dnsutils \
      pandoc \
      texlive-latex-recommended texlive-xetex texlive-luatex pandoc-citeproc etoolbox wkhtmltopdf texlive \
  && apt-get autoremove -y 

#COPY *-site.xml            $SPARK_TEMPLATE_PATH/
#COPY *.properties          $SPARK_CONF_PATH/
#COPY spark-defaults.conf   $SPARK_CONF_PATH
#COPY spark-env.sh          $SPARK_CONF_PATH

#COPY jars/* $SPARK_HOME/jars/

#WORKDIR $SPARK_HOME

#COPY docker-entrypoint.sh /usr/local/bin/
#RUN ln -s usr/local/bin/docker-entrypoint.sh entrypoint.sh
#ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["pandoc"]
