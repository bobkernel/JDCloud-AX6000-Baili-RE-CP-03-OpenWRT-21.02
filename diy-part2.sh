#!/bin/bash

# 1. 再次执行更新和安装，确保所有 feeds 已经转换成 package 目录下的索引
./scripts/feeds update -a
./scripts/feeds install -a

# 2. 更加宽容的校验逻辑：只要在所有 feeds 目录下能找到 passwall 的文件夹即可
if [ -z "$(find package/feeds -name luci-app-passwall)" ]; then
    echo "ERROR: PassWall source not found in any feed directory!"
    exit 1
else
    echo "PassWall source found! Path: $(find package/feeds -name luci-app-passwall)"
fi

# 3. 针对京东云百里定制：强制开启针对 21.02/22.03 的 nftables 支持
# 这一行确保 PassWall 能够适应新内核的防火墙
echo "CONFIG_PACKAGE_luci-app-passwall_Nftables_Transparent_Proxy=y" >> .config
