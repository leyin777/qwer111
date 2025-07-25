FROM python:3.12.7-slim

# 换成清华源（Debian 12）
RUN echo \
"Types: deb\n\
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian\n\
Suites: bookworm bookworm-updates bookworm-backports\n\
Components: main contrib non-free non-free-firmware\n\
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg\n\n\
Types: deb\n\
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian-security\n\
Suites: bookworm-security\n\
Components: main contrib non-free non-free-firmware\n\
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg\n" \
> /etc/apt/sources.list.d/tuna.sources

# 更新系统包索引并安装最小系统依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libreoffice \
        poppler-utils \
        libgl1-mesa-glx libglib2.0-0 libsm6 libxext6 libxrender1 libgomp1 \
        ffmpeg \
        fonts-wqy-zenhei fonts-wqy-microhei && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制 requirements.txt 文件并安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    -i https://pypi.tuna.tsinghua.edu.cn/simple

# 1. 把本地 EasyOCR 模型复制到镜像
COPY models/ /root/.EasyOCR/model/

# 2. 把本地 Whisper 模型复制到镜像
COPY whisper/ /root/.cache/whisper/

# 复制 app 目录到容器中
COPY app/ .

# 暴露 8000 端口
EXPOSE 8000

# 运行主应用
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]