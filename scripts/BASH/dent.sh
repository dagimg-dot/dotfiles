#!/bin/bash

function dent() {
    # Get the list of running containers
    container=$(docker ps --format "table {{.ID}}\t{{.Names}}" | fzf --header="Select a running container")

    # Check if a container was selected
    if [ -n "$container" ]; then
        # Extract the container ID from the selected line
        container_id=$(echo "$container" | awk '{print $1}')

        # Execute the docker exec command
        docker exec -it "$container_id" /bin/sh
    else 
        echo "No container selected."
    fi
}
