FROM ubuntu:20.04

# Don't prompt during apt installation
ARG DEBIAN_FROTEND=noninteractive

# Set locale and timezone
RUN apt-get update && apt-get install -yq tzdata locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LANG=en_US.UTF-8
ENV TZ=America/Chicago

# Install common build dependencies
RUN apt-get install -yq build-essential cmake git

# Install specific build dependencies
#RUN apt-get install -yq 

# Remove apt cache and configure dash
RUN rm -rf /var/lib/apt-lists/*
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure dash

WORKDIR /build
COPY . /build

#RUN

