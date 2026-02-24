#!/usr/bin/env bash
#
# ensure-jekyll.sh - Ensure Jekyll server is running
#
# Usage:
#   ./ensure-jekyll.sh [start-script]
#
# Options:
#   start-script - Path to start script (default: ./start.sh)
#
# Exit codes:
#   0 - Jekyll is running (was already or just started)
#   1 - Failed to start Jekyll
#

set -euo pipefail

PORT=4000
START_SCRIPT="${1:-./start.sh}"
TIMEOUT=30

# Check if Jekyll is already running on port 4000
check_running() {
  lsof -i :$PORT -sTCP:LISTEN 2>/dev/null | grep -q LISTEN
}

# Wait for Jekyll to be ready
wait_for_ready() {
  local elapsed=0
  echo "Waiting for Jekyll to be ready on port $PORT..."

  while [[ $elapsed -lt $TIMEOUT ]]; do
    if check_running; then
      echo "Jekyll is ready!"
      return 0
    fi
    sleep 1
    ((elapsed++))
    printf "\r  Waiting... %ds/%ds" "$elapsed" "$TIMEOUT"
  done

  echo ""
  echo "Timeout: Jekyll not ready after ${TIMEOUT}s"
  return 1
}

# Main logic
if check_running; then
  PID=$(lsof -ti :$PORT)
  echo "Jekyll already running (PID: $PID)"
  echo "URL: http://localhost:$PORT/"
  exit 0
fi

# Jekyll not running, try to start it
echo "Jekyll not running. Starting..."

if [[ ! -f "$START_SCRIPT" ]]; then
  echo "Error: Start script not found: $START_SCRIPT"
  exit 1
fi

if [[ ! -x "$START_SCRIPT" ]]; then
  echo "Making start script executable..."
  chmod +x "$START_SCRIPT"
fi

# Start in background
echo "Running: $START_SCRIPT"
"$START_SCRIPT" &
SCRIPT_PID=$!

# Wait for server to be ready
if wait_for_ready; then
  echo "URL: http://localhost:$PORT/"
  exit 0
else
  echo "Failed to start Jekyll"
  kill $SCRIPT_PID 2>/dev/null || true
  exit 1
fi
