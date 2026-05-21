---
title: 使用wsl
tags:
  - Hexo
categories:
  - Life
date: 2022-05-28 15:20:57
---

windows应用商店下载太慢，更新DNS为`4.2.2.1`,然后刷新dns`ipconfig /flushdns`.

准备阶段
```bash
# /etc/apt/source.list 更新源
# 安装常用软件
apt install net-tools
apt install curl
# nodejs
apt install nodejs
apt install npm 
npm config set registry http://npmmirror.com # 换个镜像源

# go
tar -C /usr/local -xzf goxx-amd64.tar.gz
# 在/etc/profile中加环境变量
export PATH=$PATH:/usr/local/go/bin
source /etc/profile

# ruby
sudo apt install rbenv
rbenv install --list
rbenv install 2.7.1
```
ruby
```

```
