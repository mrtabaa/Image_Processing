#!/bin/bash
# Start fullstack and open VS Code inside the container

set -euo pipefail
cd "$(dirname "$0")"

echo "🚀 Building and starting containers..."
podman-compose up -d --build

# Get container ID (must match container_name in podman-compose.yml)
CONTAINER_ID=$(podman inspect -f '{{.Id}}' back_dev 2>/dev/null || true)
if [ -z "${CONTAINER_ID}" ]; then
  echo "❌ back_dev container not found. Check 'container_name' in podman-compose.yml."
  exit 1
fi

# Ensure workspace folder shows correctly inside VS Code Explorer
TARGET="vscode-remote://attached-container+${CONTAINER_ID}/workspaces/back"

echo "💻 Opening VS Code in container..."
code --folder-uri "${TARGET}"
