#!/usr/bin/env bash
set -euo pipefail

# Get the latest commit short SHA
GIT_COMMIT=$(git rev-parse --short HEAD)
IMAGE="$DOCKER_USERNAME/devops-nodejs:$GIT_COMMIT"

echo "🔧 Building image: $IMAGE"
docker build -t $IMAGE .

echo "🔐 Logging in to DockerHub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "📤 Pushing image to DockerHub..."
docker push $IMAGE

echo "✅ Docker image pushed successfully!"
