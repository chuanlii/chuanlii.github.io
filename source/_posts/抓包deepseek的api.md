---
title: 抓包deepseek的api
tags:
  - 网络
categories:
  - 网络
date: 2025-04-02 23:07:19
---

# 问题：
直接请求deepseek的api，回答的内容和通过cline返回的结果有很多区别，比如问今天几号，前者会回答以前的时间。

通过抓包来验证一些，promot有什么区别。

# 抓包https包
1 装个 mitmproxy， 启动mitmweb.exe
  这个按中间人攻击的方式实现的，还需要装个ca证书

2 打开设置，将系统代理设置为mitmproxy的端口
3 下载证书
打开 https://mitm.it,  下载windows的证书，安装（不用设置密码）
4 在mitmweb的Flow list中，根据关键词过滤deepseek。

# 验证
直接请求api，模型是不知道时间的。问今天几号也不知道。

通过cline请求，cline会带上非常长的system的prompt，有好几万的token。user的promot中，还会带上环境详情（包括时间等）。
下一次提问时，cline会把历史的ai和user的对话都带上传过去，每次都要几十k的数据。

MCP：通过抓包发行，启动mcp后，cline会在系统prompt中，加上mcp的详细描述，每个方法参数等，之后还带上了一个查询天气的mcp的使用示例。
