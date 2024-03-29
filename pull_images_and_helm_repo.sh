#!/bin/bash

#Dir for saving images and helm repos
mkdir -p image_out
mkdir -p repo_out
:> image_list.out

#Add and fetch helm repo for vault and consul
helm repo add hashicorp https://helm.releases.hashicorp.com
helm fetch hashicorp/consul --version 0.28.0 -d ./repo_out
helm fetch hashicorp/vault --version 0.8.0 -d ./repo_out

images=(
    "registry:2.8.2"
    "hashicorp/vault-k8s:0.6.0"
    "vault:1.5.4"
    "hashicorp/consul:1.9.1"
)

for image in "${images[@]}"; do
    # Pull the image from the registry
    docker pull "$image" -q

    # Save the image to a tar file on the local disk
    image_name=$(echo "$image" | sed 's|/|_|g' | sed 's/:/_/g')
    docker save -o "./image_out/${image_name}.tar" "$image"
    echo "${image} ${image_name}.tar" >> image_list.out
    echo "$(date) ${image} saved to image_out/${image_name}.tar" 
done
