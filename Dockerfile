FROM ubuntu:xenial

MAINTAINER DigitalOcean <support@digitalocean.com>

#############################

## Environnement Variables ##

#############################

## set environment variables
ENV SHELL /bin/bash
ENV NB_USER science
ENV NB_UID 1000
ENV HOME /w205

ENV DEBIAN_FRONTEND=non-interactive
ENV LC_ALL=C
ENV LANG=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

## expose ports for jupyter notebook
EXPOSE 8888

VOLUME /w205

COPY policy-rc.d /usr/sbin
COPY scripts/* /tmp/

#################################

## Basic and Numeric libraries ##

#################################
RUN bash /tmp/010-packages
RUN bash /tmp/050-1click-base

####################################

### Python data science libraries ##

####################################
RUN bash /tmp/051-1click-python

###############################

### R data science libraries ##

###############################
#RUN bash /tmp/052-1click-R

######################################

### install deep learning libraries ##
### purposefully adding at the end  ##
### to avoid any headaches          ##

######################################
#RUN bash /tmp/053-1click-deeplearning

#RUN bash /tmp/055-1click-R-fixups
#RUN bash /tmp/070-node
RUN bash /tmp/071-gcloud-sdk
#RUN bash /tmp/080-1click-services


###################################

### user and configuration files ##

###################################

### create new user and homer directory
#RUN useradd $NB_USER \
    #&& usermod -a -G sudo $NB_USER \
    #&& mkdir -p $HOME \
    #&& chown -R  $NB_USER $HOME

### copy files to working directory
#WORKDIR $HOME

#COPY entry.sh /usr/local/bin/entry.sh
#RUN chmod 777 /usr/local/bin/entry.sh
#ENTRYPOINT /usr/local/bin/entry.sh
