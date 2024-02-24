#!/bin/bash

IMAGE_DIR="image_out"
IMAGE_LIST="image_list.out"

docker load -i ./image_out/registry_2.8.2.tar
docker run -d -p 5000:5000 --restart=always --name registry registry:2.8.2

# Wait until the container is running
until docker inspect -f '{{.State.Running}}' registry >/dev/null 2>&1; do
  echo "Waiting for 'registry' container to be running..."
  sleep 1
done

echo "'registry' container is now running. Proceeding with other steps."

cat $IMAGE_LIST | while IFS= read -r info_image; do
    image_name="$(echo $info_image | awk '{print $1}')"
    image="$(echo $info_image | awk '{print $2}')"
    docker load -i $IMAGE_DIR/$image
    docker tag $image_name localhost:5000/$image_name
    docker push localhost:5000/$image_name
done