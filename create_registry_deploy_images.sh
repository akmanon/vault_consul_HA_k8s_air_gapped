#!/bin/bash

docker load -i ./image_out/registry_2.8.2.tar
docker run -d -p 5000:5000 --restart=always --name registry registry:2.8.2


#hashicorp_consul_1.9.1.tar  hashicorp_vault-k8s_1.3.1.tar  hashicorp_vault_1.15.2.tar

for info_image in $(cat images_out.txt); do
    $image_name=$(echo $info_image | awk '{print $1}')
    $image_name=$(echo $info_image | awk '{print $2}')
    docker load -i $image
    docker tag $image_name localhost:5000/$image_name
    docker push localhost:5000/$image_name