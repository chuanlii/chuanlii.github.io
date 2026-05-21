+++
title = "Hello"
date = 2026-05-21T21:48:00+08:00
draft = false
tags = ["hugo", "guide"]
+++

# Hugo 常用命令与使用方式

这是一份 Hugo 快速使用说明。为了避免每次都输入 `D:\blog\tools\hugo\hugo.exe`，项目根目录里已经加了一个脚本：`blog.ps1`。

## 1. 最常用的命令

```powershell
# 查看帮助
.\blog.ps1 help

# 新建文章
.\blog.ps1 new my-first-post

# 本地预览
.\blog.ps1 serve

# 正式构建
.\blog.ps1 build

# 提交并发布
.\blog.ps1 publish "更新文章"
```

## 2. 新建文章

```powershell
.\blog.ps1 new my-first-post
```

使用方式：

- 这会创建文件 `content/posts/my-first-post.md`
- 如果你传的是中文标题，也可以直接用，比如：

```powershell
.\blog.ps1 new 我的新文章
```

## 3. 本地预览

```powershell
.\blog.ps1 serve
```

使用方式：

- 启动后访问 `http://localhost:1313/`
- 默认会带 `-D`，也就是连草稿一起预览
- 修改文章后，页面会自动刷新

## 4. 正式构建

```powershell
.\blog.ps1 build
```

使用方式：

- 构建结果输出到 `public/`
- 发布到 GitHub Pages 前，可以先跑一次确认没有问题

## 5. 提交并发布

```powershell
.\blog.ps1 publish "更新文章"
```

使用方式：

- 这个命令会自动执行：
- `git add .`
- `git commit -m "你的提交说明"`
- `git push origin main`
- 推送到 `main` 后，GitHub Actions 会自动构建并发布网站

## 6. 如果你想直接调用 Hugo

脚本内部其实调用的还是这个可执行文件：

```powershell
D:\blog\tools\hugo\hugo.exe
```

如果你更喜欢短命令，也可以自己先进入项目目录，再这样用：

```powershell
.\tools\hugo\hugo.exe server -D
```

但日常用根目录下的 `blog.ps1` 会更省事。
