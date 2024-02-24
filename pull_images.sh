images=(
    "registry:2.8.2"
    "nginx:latest"
    "httpd:latest"
)

for image in "${images[@]}"; do
    # Pull the image from the registry
    docker pull "$image"

    # Save the image to a tar file on the local disk
    image_name=$(echo "$image" | sed 's|/|_|g' | sed 's/:/_/g')
    docker save -o "${image_name}.tar" "$image"

done