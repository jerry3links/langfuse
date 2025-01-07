#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display messages
log() {
    echo "[`date +'%Y-%m-%d %H:%M:%S'`] $1"
}

# Variables
BRANCH=${1:-main}  # Default branch is 'main'

# Sync process
log "Starting Git sync process on branch '$BRANCH'."

# Check if in a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    log "Error: Not inside a Git repository."
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    log "Uncommitted changes detected. Staging and committing changes."
    git add .
    git commit -m "Auto-commit: $(date +'%Y-%m-%d %H:%M:%S')"
fi

# Pull latest changes from remote
log "Pulling latest changes from remote."
git fetch origin
git pull origin $BRANCH

# Push local changes to remote
log "Pushing local changes to remote."
git push origin $BRANCH

log "Git sync process completed successfully."
