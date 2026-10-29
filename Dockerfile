FROM ubuntu:24.04

# ติดตั้งแพ็กเกจที่จำเป็นสำหรับแตกไฟล์ .tar.xz และรัน BDS
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    libcurl4 \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /bedrock

# ดาวน์โหลดและแตกไฟล์ Bedrock Server จาก GitHub Releases ของคุณ
RUN curl -L -o bedrock-server.tar.xz https://github.com/uphokaew/minecraft-private/releases/download/v1/bedrock-server.tar.xz \
    && tar -xf bedrock-server.tar.xz \
    && rm bedrock-server.tar.xz

# ติดตั้ง playit.gg CLI สำหรับทำ UDP Tunnel (เพื่อให้เพื่อนเข้าพอร์ต UDP 19132 ผ่าน Render ได้)
RUN curl -SsL https://playit-cloud.github.io/LD-PPA/add-repo.sh | bash \
    && apt-get update && apt-get install -y playit

# อนุญาตสิทธิ์การรันไฟล์เซิร์ฟเวอร์
RUN chmod +x bedrock_server

# กำหนดตัวแปรสภาพแวดล้อมให้หาไลบรารีเจอ
ENV LD_LIBRARY_PATH=.

# สคริปต์เปิดใช้งาน
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080 19132/udp

ENTRYPOINT ["/entrypoint.sh"]