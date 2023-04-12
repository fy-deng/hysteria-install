## [hysteria](https://github.com/apernet/hysteria) 安装指南

1. 下载程序

//**linux-amd64**

```
sudo rm -f /usr/local/bin/hysteria && curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && chmod +x /usr/local/bin/hysteria
```

//**linux-arm64**

```
sudo rm -f /usr/local/bin/hysteria && curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-arm64 && chmod +x /usr/local/bin/hysteria
```

2. 下载配置

```
sudo mkdir -p /etc/hysteria && curl -Lo /etc/hysteria/config.json https://raw.githubusercontent.com/fy-deng/hysteria-install/diy/config_server.json
```

3. 下载systemctl配置

```
curl -Lo /etc/systemd/system/hysteria.service https://raw.githubusercontent.com/fy-deng/hysteria-install/diy/hysteria.service && systemctl daemon-reload
```

4. 上传证书和私钥

- 将证书文件改名为 **cert.crt**，将私钥文件改名为 **private.key**，将它们上传到 **/etc/ssl/private/** 目录。

5. [多端口（端口跳跃）](https://hysteria.network/zh/docs/port-hopping/)配置

<details><summary>点击查看详细步骤</summary><br>

安装

```
apt install -y iptables-persistent
```

添加

```
iptables -t nat -A PREROUTING -i eth0 -p udp --dport 16387:16485 -j DNAT --to-destination :16385
```

```
netfilter-persistent save
```

查看

```
iptables -t nat -nL --line
```

删除

```
iptables -t nat -D PREROUTING 1
```

```
netfilter-persistent save
```

</details>

6. 启动程序

```
systemctl enable --now hysteria && sleep 0.2 && systemctl status hysteria
```

| 项目 | |
| :--- | :--- |
| 程序 | **/usr/local/bin/hysteria** |
| 配置 | **/etc/hysteria/config.json** |
| 检查 | `/usr/local/bin/hysteria server -c /etc/hysteria/config.json` |
| 查看日志 | `journalctl -u hysteria --output cat -e` |
| 实时日志 | `journalctl -u hysteria --output cat -f` |

## v2rayN - V6.X 配置示例

<details><summary>点击查看</summary>

1. 下载Windows客户端程序[hysteria-windows-amd64.exe](https://github.com/apernet/hysteria/releases/latest/download/hysteria-windows-amd64.exe)，重命名为hysteria.exe，复制到v2rayN\bin\hysteria文件夹。

2. 下载客户端配置[config_client.json](https://raw.githubusercontent.com/chika0801/hysteria-install/main/config_client.json)，修改chika.example.com为证书中包含的域名，修改10.0.0.1为VPS的IP。

3. 服务器 ——> 添加自定义配置服务器 ——> 浏览 ——> 选择客户端配置 ——> Core类型 hysteria ——> Socks端口 50000

![1](https://user-images.githubusercontent.com/88967758/227562172-1f811375-69b1-4f1e-938b-68abb13f0278.png)

小技巧：只要证书在有效期内，证书中包含的域名不用解析到VPS的IP。一份证书，在多个VPS上使用。

</details>

## Shadowrocket 配置示例

<details><summary>点击查看</summary><br>

| 选项 | 值 |
| :--- | :--- |
| 类型 | Hysteria |
| 地址 | VPS的IP |
| 端口 | 16385,16387-16485 |
| 密码 | chika |
| 混淆 | 留空 |
| 协议 | UDP |
| 允许不安全 | 不选 |
| UDP 转发 | 选上 |
| 快速打开 | 选上 |
| SNI | 证书中包含的域名 |
| ALPN | h3 |
| 上行速度 | 20 |
| 下行速度 | 100 |

</details>

## PassWall 配置示例

<details><summary>点击查看</summary><br>

| 选项 | 值 | 对应参数 |
| :--- | :--- | :--- |
| 类型 | Hysteria |  |
| 地址（支持域名） | VPS的IP | "server" |
| 端口 | 16385 | "server" |
| 端口跳跃额外端口 | 16387-16485 | "server" |
| 协议 | UDP | "protocol" |
| 混淆密码 | 留空 | "obfs" |
| 认证类型 | STRING |  |
| 认证密码 | chika | "auth_str" |
| QUIC TLS ALPN | h3 | "alpn" |
| 快速打开 | 勾上 | "fast_open" |
| 域名 | 证书中包含的域名 | "server_name" |
| 允许不安全连接 | 不勾 | "insecure" |
| 最大上行(Mbps) | 50 | "up_mbps" |
| 最大下行(Mbps) | 150 | "down_mbps" |
| QUIC 流接收窗口 | 6710886 | "recv_window_conn" |
| QUIC 连接接收窗口 | 16777216 | "recv_window" |
| 握手超时 | 留空 | "handshake_timeout" |
| 空闲超时 | 留空 | "idle_timeout" |
| 端口跳跃时间 | 留空 | "hop_interval" |
| 禁用 MTU 检测 | 不勾 | "disable_mtu_discovery" |

</details>

## ShadowSocksR Plus+ 配置示例

<details><summary>点击查看</summary><br>

| 选项 | 值 | 对应参数 |
| :--- | :--- | :--- |
| 服务器节点类型 | Hysteria |
| 服务器地址 | VPS的IP | "server" |
| 端口 | 16385 | "server" |
| 协议 | udp | "protocol" |
| 验证类型 | string |  |
| 验证载荷 | chika | "auth_str" |
| QUIC 连接接收窗口 | 16777216 | "recv_window" |
| QUIC 流接收窗口 | 6710886 | "recv_window_conn" |
| 禁用 MTU 探测 | 不勾 | "disable_mtu_discovery" |
| 延迟启动 | 不勾 | "lazy_start" |
| 上行链路容量 | 50 | "up_mbps" |
| 下行链路容量 | 150 | "down_mbps" |
| 混淆密码（可选） | 留空 | "obfs" |
| TLS 主机名 | 证书中包含的域名 | "server_name" |
| QUIC TLS ALPN | h3 | "alpn" |
| 允许不安全连接 | 不勾 | "insecure" |
| 自签证书 | 不勾 |  |
| TCP 快速打开 | 勾上 | "fast_open" |
| 启用自动切换 | 不勾 |  |
| 本地端口 | 1234 |  |

</details>
