#!/bin/bash

# 1. 更新并安装所有 feeds 源 (确保刚刚加入的 kenzo 源生效)
./scripts/feeds update -a
./scripts/feeds install -a

# 2. 修改默认 IP（可选，默认是 192.168.1.1，如需修改请取消下行注释）
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 3. 清除默认密码（可选，设置为空密码）
sed -i 's/$1$V4UetPzk$GCPwD9snMSqmxvQHBy.q7.//g' package/lean/default-settings/files/zzz-default-settings

# 4. 强制校验 PassWall 是否存在，若不存在则报错，避免浪费编译时间
if [ ! -d "package/feeds/kenzo/luci-app-passwall" ]; then
    echo "ERROR: PassWall source not found!"
    exit 1
fi
