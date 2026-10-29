FROM ubuntu:24.04

# ติดตั้งแพ็กเกจที่จำเป็นสำหรับแตกไฟล์และรันเซิร์ฟเวอร์
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    libcurl4 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /bedrock

# ดาวน์โหลดและแตกไฟล์ Bedrock Server จาก GitHub Releases ของคุณ
RUN curl -L -o bedrock-server.tar.xz https://github.com/uphokaew/minecraft-private/releases/download/v1/bedrock-server.tar.xz \
    && tar -xf bedrock-server.tar.xz \
    && rm bedrock-server.tar.xz

# ดาวน์โหลด playit CLI แบบตรงๆ (เวอร์ชันล่าสุดสำหรับ Linux AMD64)
RUN curl -L -o /usr/local/bin/playit https://github.com/playit-cloud/playit-agent/releases/download/v0.15.2/playit-0.15.2_x86_64 \
    && chmod +x /usr/local/bin/playit

# อนุญาตสิทธิ์การรันไฟล์เซิร์ฟเวอร์ Minecraft
RUN chmod +x bedrock_server

# กำหนดตัวแปรสภาพแวดล้อม
ENV LD_LIBRARY_PATH=.

# คัดลอกและตั้งค่าสิทธิ์ให้ entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080 19132/udp

ENTRYPOINT ["/entrypoint.sh"]