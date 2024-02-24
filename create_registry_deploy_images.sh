#!/bin/bash

docker load -i registry_2.8.2.tar
docker run -d -p 5000:5000 --restart=always --name registry registry:2.8.2
