#!/bin/bash

APP_VERSION=$1  # Expected: blue or green

if [[ "$APP_VERSION" != "blue" && "$APP_VERSION" != "green" ]]; then
  echo "❌ Usage: ./deploy.sh blue OR ./deploy.sh green"
  exit 1
fi

IMAGE_TAG="ladipo/bluegreen:$APP_VERSION"

echo "🚧 Building $APP_VERSION image..."
docker build -t $IMAGE_TAG --build-arg APP_VERSION=$APP_VERSION ./app

echo "📦 Pushing to Docker Hub..."
docker push $IMAGE_TAG

echo "🧼 Stopping current $APP_VERSION container if running..."
docker rm -f $APP_VERSION 2>/dev/null || true

echo "🚀 Running $APP_VERSION container..."
docker run -d --name $APP_VERSION \
  --network bluegreen \
  -e APP_VERSION=$APP_VERSION \
  $IMAGE_TAG

echo "✅ $APP_VERSION container deployed and running."
