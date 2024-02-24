#!/bin/bash

:> image_out.txt
mkdir -p image_out

#Add and fetch helm repo for vault and consul
helm repo add hashicorp https://helm.releases.hashicorp.com
helm fetch hashicorp/consul --version 0.28.0 -d ./image_out
helm fetch hashicorp/vault --version 0.8.0 -d ./image_out

images=(
    "hashicorp/vault-k8s:1.3.1"
    "hashicorp/vault:1.15.2"
    "hashicorp/consul:1.9.1"
)

for image in "${images[@]}"; do
    # Pull the image from the registry
    docker pull "$image"

    # Save the image to a tar file on the local disk
    image_name=$(echo "$image" | sed 's|/|_|g' | sed 's/:/_/g')
    docker save -o "./image_out/${image_name}.tar" "$image"
    echo "${image_name}.tar" >> image_out.txt
done