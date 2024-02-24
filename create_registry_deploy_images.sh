#!/bin/bash

IMAGE_DIR="image_out"

docker load -i ./image_out/registry_2.8.2.tar
docker run -d -p 5000:5000 --restart=always --name registry registry:2.8.2


#hashicorp_consul_1.9.1.tar  hashicorp_vault-k8s_1.3.1.tar  hashicorp_vault_1.15.2.tar

cat "image_list.txt" | while IFS= read -r info_image; do
    image_name="$(echo $info_image | awk '{print $1}')"
    image="$(echo $info_image | awk '{print $2}')"
    docker load -i $IMAGE_DIR/$image
    docker tag $image_name localhost:5000/$image_name
    docker push localhost:5000/$image_name
done