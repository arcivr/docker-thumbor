FROM apsl/thumbor

MAINTAINER Derek Lucas <derek.lucas@arcivr.com>

VOLUME /data

ENV HOME /usr/src/app
ENV SHELL bash
ENV WORKON_HOME /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install -r /usr/src/app/requirements.txt
