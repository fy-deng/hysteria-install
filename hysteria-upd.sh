#!/bin/bash

# 检查系统架构
ARCH=$(uname -m)

# 根据架构执行命令
if [[ "$ARCH" == "x86_64" || "$ARCH" == "amd64" ]]; then
  echo "Detected AMD64 architecture. Download hysteria now."
  sudo curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && \
  sudo chmod +x /usr/local/bin/hysteria
  
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
  echo "Detected ARM64 architecture. Download hysteria now."
  sudo curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-arm64 && \
  sudo chmod +x /usr/local/bin/hysteria
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi