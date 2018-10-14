#!/bin/bash

IP=$(ifconfig ens32 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}')

mkdir -p prometheus_data
chown -R 65534:65534 prometheus_data

docker run -d --restart=always \
    --name prom \
    -v $(pwd)/prometheus.yml:/prometheus.yml \
    -v $(pwd)/prometheus_data:/prometheus \
    -p 9090:9090 \
    prom/prometheus --config.file=/prometheus.yml --storage.tsdb.retention=30d --web.listen-address="$IP:9090"

