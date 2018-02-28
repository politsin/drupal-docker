#!/bin/bash

docker stop drupal-mysql
docker stop drupal-phpfpm
docker stop drupal-nginx

docker rm drupal-mysql
docker rm drupal-phpfpm
docker rm drupal-nginx