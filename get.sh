#!/bin/bash

apt-get update && \
apt-get install git && \
git clone https://github.com/politsin/docker4drupal /opt/docker4drupal && \
cd /opt/docker4drupal
