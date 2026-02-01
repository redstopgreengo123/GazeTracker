#!/bin/bash
# Download MediaPipe Face Landmarker model for Android
# Run this script from the project root directory

ASSETS_DIR="app/src/main/assets"
MODEL_URL="https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/1/face_landmarker.task"
MODEL_FILE="face_landmarker.task"

echo "Creating assets directory..."
mkdir -p "$ASSETS_DIR"

echo "Downloading MediaPipe Face Landmarker model..."
curl -L "$MODEL_URL" -o "$ASSETS_DIR/$MODEL_FILE"

if [ -f "$ASSETS_DIR/$MODEL_FILE" ]; then
    FILE_SIZE=$(ls -lh "$ASSETS_DIR/$MODEL_FILE" | awk '{print $5}')
    echo "✓ Downloaded successfully: $ASSETS_DIR/$MODEL_FILE ($FILE_SIZE)"
else
    echo "✗ Download failed!"
    exit 1
fi

echo ""
echo "Model is ready. You can now build the app."
