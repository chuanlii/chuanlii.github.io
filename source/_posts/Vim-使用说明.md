---
title: Vim 使用说明
tags:
  - vim
categories:
  - linux
date: 2020-12-08 22:19:45
---

vim两种模式，insert和normal模式，normal就是命令模式，insert就是编辑模式。

参考https://coolshell.cn/articles/5426.html

非常全的：https://vim.rtorr.com/lang/zh_cn

```shell
# 插入模式
i	光标前插入
a	光标后插入，append
o	在当前行后插入一个新行

#移动
0	行前
^	本行第一个非空白字符
$	本行最后一个字符
/pattern	搜索pattern，回车后，按n到下一个

# 粘贴拷贝
dd	删除当前行，并存入剪切板
p 	粘贴剪切板
yy	拷贝当前行，等于ddp

# 撤回
u	undo
ctrl+r	redo

# 打开保存退出
:e <filename> 打开文件
:w	保存
:saveas <name> 另存为
:bn	切换到下一个文件 next
:bp	切换到上一个文件 pre

# 高级
.	重复上一次命令
N<command>	重复N次
3dd	删除3行
5p	粘贴5次

# 移动
:set nu	显示行
gg	移动到第一行
G	移动到最后一行
:12	移动到第12行
w	下一个单词开头
e	下一个单词结尾，若在当前单词中间，就移动到当前单词结尾
b	当前单词开头
%	在括号上使用，移动到匹配的另一个括号
*	移动到和当前单词相同的下一个单词
#	移动到和当前单词相同的上一个单词

<start position><command><end position>
0y$	从行开头复制到行结尾
ye	从当前位置拷贝到本单词的最后一个字符
yb	从当前位置前一个次方拷贝到本单词的第一个字符

v 进入可视化
v 方向键选择，然后y，可以范围复制
v 方向键选择，然后d，可以范围删除
```

