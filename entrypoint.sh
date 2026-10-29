#!/bin/bash

# รัน playit ใน Background สำหรับทำ UDP Tunnel
playit &

# ค้นหาตำแหน่งไฟล์ bedrock_server และรันขึ้นมา
SERVER_BIN=$(find . -name "bedrock_server" -print -quit)

if [ -z "$SERVER_BIN" ]; then
    echo "Error: Could not find bedrock_server binary!"
    exit 1
fi

echo "Starting Minecraft Bedrock Server..."
exec $SERVER_BIN