---
title: mcp学习
tags:
  - mcp
  - ai
categories:
  - AI
date: 2025-03-21 22:51:46
---

# Cline 安装 Node.js 启动的 MCP Server 连接失败

## 问题描述

在 Windows 环境下，使用 npx 启动 MCP Server 时出现以下错误：

```
spawn npx ENOENT spawn npx ENOENT
```

## 解决方案

将启动方式从 npx 改为 node 启动。

### 具体步骤

1. 安装依赖：

```bash
npm install -g @modelcontextprotocol/server-filesystem
```

2. 修改配置文件：

```json
"filesystem": {
  "command": "node",
  "args": [
    "C:/Users/xxx/AppData/Roaming/npm/node_modules/@modelcontextprotocol/server-filesystem/dist/index.js",
    "e:/study/my_pages"
  ],
  "disabled": false,
  "autoApprove": [],
  "timeout": 30
}
```

### 修改前配置

```json
"filesystem": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-filesystem", 
    "e:/study/my_pages"
  ],
  "disabled": false,
  "autoApprove": [],
  "timeout": 30
}
```
