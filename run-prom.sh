#!/bin/bash

IP=$(ifconfig ens32 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}')

mkdir -p prometheus_data
chown -R 65534:65534 prometheus_data

docker run -d --restart=always \
    --net=host \
    --name=prom \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/prometheus_data:/prometheus \
    prom/prometheus --config.file=/conf/prometheus.yml --storage.tsdb.retention=30d --web.listen-address="$IP:9090" --web.enable-lifecycle

