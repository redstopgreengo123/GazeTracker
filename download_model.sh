#!/bin/bash
# Download MediaPipe Face Landmarker model for GazeTracker
# Run this script from the project root directory

set -e

ASSETS_DIR="app/src/main/assets"
MODEL_URL="https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/latest/face_landmarker.task"
MODEL_FILE="$ASSETS_DIR/face_landmarker.task"

echo "Creating assets directory..."
mkdir -p "$ASSETS_DIR"

echo "Downloading MediaPipe Face Landmarker model..."
curl -L -o "$MODEL_FILE" "$MODEL_URL"

if [ -f "$MODEL_FILE" ]; then
    FILE_SIZE=$(stat -f%z "$MODEL_FILE" 2>/dev/null || stat -c%s "$MODEL_FILE")
    echo "✓ Model downloaded successfully: $MODEL_FILE"
    echo "  File size: $FILE_SIZE bytes"
else
    echo "✗ Failed to download model"
    exit 1
fi

echo ""
echo "Done! The face_landmarker.task model is ready for use."
