---
title: arch升级
date: 2025-03-15 22:51:16
tags: 
  - arch
categories:
  - environment
---

长期没有使用的arch系统的电脑，升级报错。

pacman -Syyu 更新时，提示glibc版本过低，需要2.38版本，所有的都无法升级

```bash
pacman: /usr/lib/libc.so.6: version `GLIBC_2.38' not found (required by pacman)
pacman: /usr/lib/libc.so.6: version `GLIBC_2.38' not found (required by /usr/lib/libalpm.so.15)
```

**失败的尝试**：到镜像仓库，手动下载后，`pacman -U` 安装，仍然提示glibc问题

**解决方式**：

打开 <https://aur.archlinux.org/packages/pacman-static> 找到置顶评论，下载一个二进制包
<https://pkgbuild.com/~morganamilo/pacman-static/x86_64/bin/>
下载好这个包之后，直接 `chmod +x pacman-static`

最后执行下面的命令安装缺失的 glibc 

```bash
./pacman-static -S glibc
```

但是提示秘钥检查错误 `is unknown trust`

**解决方式**：
直接临时禁用，到`/etc/pacman.conf` 设置 `SigLevel = Never`，然后重试即可

之后去掉禁用，重新设置秘钥

```bash
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
```

之后正常安装即可

