#!/bin/bash

APP_VERSION=$1 # blue or green
IMAGE_TAG="ladipo/bluegreen:$APP_VERSION"

echo "Building $APP_VERSION image..."
docker build -t $IMAGE_TAG --build-arg APP_VERSION=$APP_VERSION ./app

echo "Pushing to Docker Hub..."
docker push $IMAGE_TAG

echo "Stopping current $APP_VERSION container if running..."
docker rm -f $APP_VERSION || true

echo "Running $APP_VERSION container..."
docker run -d --name $APP_VERSION -e APP_VERSION=$APP_VERSION $IMAGE_TAG
