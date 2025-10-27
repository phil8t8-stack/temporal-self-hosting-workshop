#/bin/bash

nohup socat TCP-LISTEN:8080,fork,reuseaddr TCP:k3d-dev-server-0:30080 >>/tmp/socat-8080.log 2>&1 &
nohup socat TCP-LISTEN:7233,fork,reuseaddr TCP:k3d-dev-server-0:30233 >>/tmp/socat-7233.log 2>&1 &
