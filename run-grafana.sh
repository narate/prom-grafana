#!/bin/bash

IP=$(ifconfig ens32 | grep 'inet addr' | cut -d ':' -f 2 | awk '{print $1}')

mkdir -p grafana-storage
chown -R 472.472 grafana-storage

docker run -d --restart=always \
	--name=grafana \
	-p $IP:3000:3000 \
	-v $(pwd)/grafana-storage:/var/lib/grafana \
	-v $(pwd)/grafana.ini:/etc/grafana/grafana.ini \
	grafana/grafana:5.2.2
