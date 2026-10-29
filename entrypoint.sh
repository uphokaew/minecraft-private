#!/bin/bash

# รัน playit ใน Background
playit &

# ค้นหาตำแหน่งโฟลเดอร์ที่มีไฟล์ bedrock_server อยู่
SERVER_DIR=$(find . -name "bedrock_server" -exec dirname {} \; | head -n 1)

if [ -z "$SERVER_DIR" ]; then
    echo "Error: Could not find bedrock_server binary!"
    exit 1
fi

cd "$SERVER_DIR"
echo "Working directory changed to: $(pwd)"

# ถ้ายังไม่มี server.properties ให้สร้างไฟล์ตั้งค่าพื้นฐานขึ้นมา
if [ ! -f "server.properties" ]; then
    echo "server-name=Dedicated Server" > server.properties
    echo "gamemode=survival" >> server.properties
    echo "difficulty=easy" >> server.properties
    echo "server-port=19132" >> server.properties
    echo "server-portv6=19133" >> server.properties
    echo "Created default server.properties"
fi

echo "Starting Minecraft Bedrock Server..."
exec ./bedrock_server