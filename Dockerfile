# dns-black-hole Dockerfile
#
# Author: Loan Lassalle <https://github.com/lassalleloan>

FROM alpine:latest

MAINTAINER Loan Lassalle <https://github.com/lassalleloan>

# Install Python 3, PIP, Wget and StevenBlack/hosts sources
RUN apk add --no-cache python3 py3-lxml wget && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    wget -P /dns-black-hole https://github.com/StevenBlack/hosts/archive/master.zip && \
    unzip -d /dns-black-hole /dns-black-hole/master.zip && \
    rm -f /dns-black-hole/master.zip && \
    pip3 install --user -r /dns-black-hole/hosts-master/requirements.txt

WORKDIR /dns-black-hole/hosts-master

# Environment variables come from .conf configuration file 
ENTRYPOINT "python3" \
    "updateHostsFile.py" \
    "--auto" \
    "--extensions" $EXTENSION_1 $EXTENSION_2 $EXTENSION_3 $EXTENSION_4 \
    "--output" "/dns-black-hole/etc"
