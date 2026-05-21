+++
title = "Hello"
date = 2026-05-21T21:48:00+08:00
draft = false
tags = ["hugo", "guide", "commands"]
+++

# Hugo 常用命令与使用方式

这是一份放在 `hello.md` 里的 Hugo 快速使用说明，方便你后面直接边写边查。

## 1. 初始化与新建内容

```powershell
# 当前项目里使用 Hugo 可执行文件
D:\blog\tools\hugo\hugo.exe version

# 新建一篇文章
D:\blog\tools\hugo\hugo.exe new content posts/my-first-post.md

# 新建一个独立页面
D:\blog\tools\hugo\hugo.exe new content about.md
```

使用方式：

- `new content` 会按 Hugo 的 archetype 生成 Markdown 文件。
- 新文章默认位置通常放在 `content/posts/`。
- 如果文章头部 `draft = true`，默认不会出现在正式构建中。

## 2. 本地预览

```powershell
# 启动本地开发服务器
D:\blog\tools\hugo\hugo.exe server

# 连草稿一起预览
D:\blog\tools\hugo\hugo.exe server -D
```

使用方式：

- 启动后访问 `http://localhost:1313/`。
- 修改 `content/`、`layouts/`、`static/` 后，页面通常会自动刷新。
- `-D` 等价于 `--buildDrafts`，适合写草稿时预览。

## 3. 正式构建

```powershell
# 生成静态站点文件
D:\blog\tools\hugo\hugo.exe

# 清理目标目录后再构建
D:\blog\tools\hugo\hugo.exe --cleanDestinationDir
```

使用方式：

- 构建结果会输出到 `public/`。
- GitHub Pages 最终发布的就是构建后的静态文件。
- 如果你后面用了 GitHub Actions，通常会在 CI 里执行这一步。

## 4. 常见目录

```text
content/   网站内容，文章和页面
static/    原样拷贝的静态文件，如图片、favicon
themes/    主题目录
hugo.toml  站点主配置
public/    构建产物
```

使用方式：

- 写文章主要改 `content/`。
- 放图片可以用 `static/`，然后在文章中按站点根路径引用。
- 改站点名称、菜单、主题参数主要编辑 `hugo.toml`。

## 5. 你接下来最常做的事

```powershell
# 1) 写新文章
D:\blog\tools\hugo\hugo.exe new content posts/second-post.md

# 2) 本地预览
D:\blog\tools\hugo\hugo.exe server -D

# 3) 确认没问题后正式构建
D:\blog\tools\hugo\hugo.exe
```

如果你能看到这篇文档，说明站点、主题和文章渲染都已经正常工作。

## 6. 补充说明

### 什么时候用 `server`

开发和改样式时，优先用 `hugo server -D`，因为它会自动刷新，效率最高。

### 什么时候直接用 `hugo`

准备部署前，执行一次 `hugo` 做正式构建，检查 `public/` 里的输出是否正常。
