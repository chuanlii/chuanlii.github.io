---
title: WebAssembly
tags:
  - Hexo
categories:
  - Life
date: 2022-05-28 16:20:51
---

一个WebAssembly例子

```

rustc --version 检查是否安装
rustup 安装和版本管理工具
Cargo：Rust 的构建工具和包管理器
rustup update 升级rust

cargo new hello 创建项目
cargo build 可以构建项目
cargo run 可以运行项目
cargo test 可以测试项目
cargo doc 可以为项目构建文档
cargo publish 可以将库发布到 crates.io


```

更新cargo 源
在.cargo/下，创建config文件，配置如下
```
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```

```
安装wasm-pack
sudo curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

cargo install cargo-generate
cargo generate --git https://github.com/rustwasm/wasm-pack-template

wasm-pack build 


```
