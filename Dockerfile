FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
  tmux \
  python3 \
  python3-pip \
  bash-completion \
  vim

RUN pip3 install \
      beautifulsoup4 \
      bokeh \
      jupyter \
      jupyterhub \
      jupyterlab \
      matplotlib \
      networkx \
      nltk \
      notebook \
      numpy \
      pandas \
      pyzmq \
      requests \
      scikit-image \
      scikit-learn \
      scipy \
      seaborn \
      sqlalchemy \
      statsmodels \
      sympy \
      textblob

COPY bash.bashrc /etc/

