#!/usr/bin/env bash

docker login -u "$REGISTRY_USER" -p "$REGISTRY_TOKEN" ghcr.io

backend_image="ghcr.io/fadingafterglow/splitfast-backend:main"
frontend_image="ghcr.io/fadingafterglow/splitfast-frontend:master"

if [ "$1" = "backend" ]; then
	echo "Pulling backend image..."
	docker pull "$backend_image"
elif [ "$1" = "frontend" ]; then
	echo "Pulling frontend image..."
	docker pull "$frontend_image"
elif [ "$1" = "all" ]; then
	echo "Pulling all images..."
	docker pull "$backend_image"
	docker pull "$frontend_image"
else
	echo "Unknow redeploy target"
	exit 1
fi

echo "Stopping containers..."
sudo systemctl stop splitfast.service

echo "Starting containers..."
sudo systemctl start splitfast.service