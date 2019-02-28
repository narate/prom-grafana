#!/bin/bash

IP=$(ifconfig ens32 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}')

docker run -d --restart=always \
  --net=host \
  --pid=host \
  --name=node-exporter \
  quay.io/prometheus/node-exporter --web.listen-address="$IP:9100"

