#!/bin/bash

# เริ่มต้นรัน playit ใน Background เพื่อสร้าง UDP Tunnel
# หมายเหตุ: ครั้งแรกที่รัน ดู Link ใน Log ของ Render เพื่อไปกด Claim บนเว็บไซต์ playit.gg
playit &

# รันตัว Minecraft Bedrock Dedicated Server
./bedrock_server