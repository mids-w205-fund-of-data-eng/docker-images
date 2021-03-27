FROM atox120/spark-minimal:0.0.8
MAINTAINER Mark Mims <mark.mims@gmail.com>, Alexander To <alexander.to@berkeley.edu>

ENV ANACONDA_VERSION 2020.11
ENV PY4J_VERSION     0.10.9.2

WORKDIR /

RUN apt-get install -y bzip2 \
  && curl -OL http://repo.continuum.io/archive/Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh \
  && chmod 755 Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh \
  && /Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh -b -p /opt/anaconda3 \
  && rm /Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh \
  && /opt/anaconda3/bin/conda install pyarrow parquet-cpp arrow-cpp -c conda-forge

ENV PATH       /opt/anaconda3/bin:$PATH
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-$PY4J_VERSION-src.zip

#COPY spark-defaults.conf $SPARK_CONF_PATH

WORKDIR $SPARK_HOME

CMD ["pyspark"]
