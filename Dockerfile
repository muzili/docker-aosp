FROM ubuntu:14.04

MAINTAINER Joshua Lee <muzili@gmail.com>


#Update the sources.list from china
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe restricted" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-security main universe restricted" >> /etc/apt/sources.list

#
# fundamental packages
#
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386 && apt-get update -qq
RUN apt-get install -y apt-transport-https ca-certificates wget \
    curl vim git man-db make bison g++-multilib gperf libxml2-utils \
    software-properties-common libstdc++6:i386 lib32z1 lib32bz2-1.0 \
    lib32ncurses5 openjdk-7-jdk build-essential expect

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod 755 /usr/local/bin/repo

# The persistent data will be in these two directories, everything else is
# considered to be ephemeral
VOLUME ["/ccache", "/aosp"]
#
# user account
#
ENV MYNAME android
ENV MYPASS android
ENV HOME /home/$MYNAME

RUN useradd --create-home -d $HOME --shell /bin/bash --user-group \
    --groups adm,sudo $MYNAME \
    && echo "$MYNAME:$MYPASS" | chpasswd

ADD gitconfig /home/$MYNAME/.gitconfig
ADD ssh_config /home/$MYNAME/.ssh/config
RUN chown $MYNAME:$MYNAME -R /home/$MYNAME

USER $MYNAME
WORKDIR /aosp

# Improve rebuild performance by enabling compiler cache
ENV USE_CCACHE 1
ENV CCACHE_DIR /ccache

