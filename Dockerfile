FROM ubuntu:24.04

# ติดตั้งแพ็กเกจที่จำเป็น
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

# ดาวน์โหลด playit CLI (ลิงก์ตรงเวอร์ชัน Linux x86_64 ที่ถูกต้อง)
RUN curl -L -o /usr/local/bin/playit https://github.com/playit-cloud/playit-agent/releases/download/v0.15.2/playit-0.15.2_x86_64 \
    && chmod +x /usr/local/bin/playit

# ค้นหาและให้สิทธิ์รันไฟล์ bedrock_server ทั้งหมดในโฟลเดอร์
RUN find . -name "bedrock_server" -exec chmod +x {} \;

ENV LD_LIBRARY_PATH=.

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080 19132/udp

ENTRYPOINT ["/entrypoint.sh"]