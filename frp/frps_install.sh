#!/bin/sh

FRP_PKG_SHORT_NAME='frp_0.27.1_linux_amd64'
FRP_PKG_NAME="${FRP_PKG_SHORT_NAME}.tar.gz"

echo '当前目录为：'
pwd

# 下载
wget https://github.com/fatedier/frp/releases/download/v0.27.1/${FRP_PKG_NAME}
# 解压
tar -xzvf ${FRP_PKG_NAME}

# 重命名为frp目录
mv ${FRP_PKG_SHORT_NAME} frp

cd frp

# 将frp服务的相关文件拷贝到系统的对应位置，以便直接利用写好的service自启动脚本：
cp frps /usr/bin/frps
mkdir /etc/frp
cp frps.ini /etc/frp/frps.ini
cp systemd/frps.service /usr/lib/systemd/

echo 'frps.ini配置文件内容为：'

cat frps.ini

# 修改配置文件后需要刷新服务（如果已经enable过的话）
systemctl daemon-reload
# 启用自启动服务
systemctl enable frps.service
# 查看运行状态
systemctl status frps.service

echo 'frps服务安装完毕！'
echo '如果需要修改配置，需要编辑/etc/frp/frps.ini'
