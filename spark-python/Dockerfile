FROM midsw205/spark-minimal:latest
MAINTAINER Mark Mims <mark.mims@gmail.com>

ENV ANACONDA_VERSION 4.4.0
ENV PY4J_VERSION     0.10.4

WORKDIR /

RUN apt-get install -y bzip2 \
&& curl -OL http://repo.continuum.io/archive/Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh \
&& chmod 755 Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh \
&& /Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh -b -p /opt/anaconda3 \
&& rm /Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh \
&& /opt/anaconda3/bin/conda install pyarrow arrow-cpp parquet-cpp -c conda-forge

ENV PATH       /opt/anaconda3/bin:$PATH
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-$PY4J_VERSION-src.zip

#COPY spark-defaults.conf $SPARK_CONF_PATH

WORKDIR $SPARK_HOME

CMD ["pyspark"]
