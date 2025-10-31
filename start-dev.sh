#!/bin/bash
# Start fullstack and open VS Code inside the container (reuses current window)

set -euo pipefail
cd "$(dirname "$0")"

echo "🚀 Starting Podman Compose stack..."
podman-compose up -d --build

# Grab container ID by name (fails if not found)
CONTAINER_ID=$(podman inspect -f '{{.Id}}' back_dev 2>/dev/null || true)
if [ -z "${CONTAINER_ID}" ]; then
  echo "❌ back_dev container not found. Check service/container_name in podman-compose.yml"
  exit 1
fi

TARGET="vscode-remote://attached-container+${CONTAINER_ID}/workspaces/back"

# If running inside VS Code: reuse the **same** window (no second window)
if [ -n "${VSCODE_IPC_HOOK_CLI:-}" ] || [ -n "${VSCODE_GIT_IPC_HANDLE:-}" ]; then
  echo "💻 Reusing current VS Code window..."
  code --reuse-window --folder-uri "${TARGET}"
else
  # Launched from a normal terminal/Podman Desktop: open normally
  echo "💻 Opening VS Code..."
  code --folder-uri "${TARGET}" &
fi

