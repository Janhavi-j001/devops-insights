#Cleanup Old Docker Images (locally or on EC2)
#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Cleaning up Docker images, containers, networks..."
docker container prune -f
docker image prune -f
docker network prune -f
