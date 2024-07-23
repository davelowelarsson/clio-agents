#!/bin/bash

# Load environment variables from the .env file
set -o allexport
source .env
set -o allexport

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy the agent files from the source directory to the destination directory
cp "$SOURCE_DIR"/*.gpt "$DEST_DIR/"

# Verify that the files have been copied
if [ $? -eq 0 ]; then
  echo "Agents copied successfully to $DEST_DIR"
else
  echo "Failed to copy agents"
  exit 1
fi
