---
title: 使用hexo创建github pages
---


hexo：一个使用简单的博客框架，通过md文件生成静态页面。
Travis CI：持续集成工具，检测到github上的提交后，自动执行脚本，更新静态页面
hexo主题：[ILS](https://github.com/XPoet/hexo-theme-keep)

创建两个分支，main和gp-pages，main存放所有文件，gh-pages存放生成的页面，同时在settings里面将gh-pages设置为github Pages的默认分支。
使用时，只需要git上传md文件，travis就会自动执行脚本，更新gh-pages分支内容。
### 使用

``` bash
# 创建
$ hexo new "My New Post"

# 本地生成
$ hexo g 

# 本地演示
$ hexo server

# 上传
$ git push origin main

```


