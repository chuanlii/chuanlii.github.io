---
title: python中一些问题
tags:
  - 编程
categories:
  - python
date: 2025-03-23 19:34:29
---

# Python模块导入问题

## 目录结构

```text
├── proj
│   ├── p1
│   │   ├── __init__.py
│   │   ├── m1a.py
│   │   └── m1b.py
│   ├── p2
│   │   ├── __init__.py
│   │   └── m2c.py
│   ├── md.py
│   └── main.py
```

## 原理

当前执行模块作为主模块，会把主模块所在当前路径加入`sys.path`，会在`sys.path`中找所在的包。
`main.py`作为主模块执行时，是看不到上一层`proj`的，只能看到`p1`，`p2`，`md`
`m1b.py`作为主模块是看不到`p1`的
每个module的`__name__`都是引用的路径，比如`m1a.py`的`__name__`是`p1.m1a`
当`m1a.py`作为主模块执行时，`m1a.py`的`__name__`就是`__main__`了

## 问题

```text
├── proj
│   ├── p1
│   │   ├── __init__.py
│   │   ├── m1a.py  # from p1.m1b import fb; def fa() 等价于 from .m1b import fb; def fa()
│   │   └── m1b.py  # fb()
│   └── main.py     # from p1.m1a import fa; fa()
```

执行`main.py`，正常，因为当前路径为`proj/`，`m1a`中的`.m1b`等于`p1.m1b`，`main.py`是可见的
执行`m1a.py`，就会报错`attempted relative import with no known parent package`，因为：
当前路径是`proj/p1/`，只能看到`p1`下面的内容，但是`m1a`中的`.m1b`等于`p1.m1b`，看不到`p1`，所以找不到`p1.m1b`

将`m1a.py`改为`from m1b import fb`：执行`m1a.py`可以，但`main.py`会报错
将`m1a.py`改为`from p1.m1b import fb`：执行`m1a.py`会报错，但`main.py`正常

## 解决方案

### 1. 避免这种场景（推荐）
不要在`m1a.py`中执行
要执行就把代码放到外面的`main.py`中

### 2. 使用 -m 参数
要执行`m1a.py`，不要用`python m1a.py`
首先进入`proj/`下，使用 `python -m p1.m1a` 来执行，这样`sys.path`中是 `proj`，这时就能看到`proj/`下面的包`p1`了

如果`m1a.py`中是 `from p1.m1b import fb`
执行`python m1a.py`，则`sys.path`中有 `proj/p1`，这时看不到包`p1`


### 3. 使用 setup.py 安装包
在`proj/`下，创建`setup.py`：

```python
from setuptools import setup, find_packages

setup(
    name = 'test_package',
    packages = find_packages(),
)
```

执行：
```bash
python setup.py install --user  # 这个可以在当前目录看到安装的内容
python p1/pa.py
```

### 4. 在 __init__.py 中添加包路径
在`m1a.py`中改为相对引用 `from m1b import fb`
在`__init__.py`中加上：

```python
import os
import sys

sys.path.append(os.path.dirname(os.path.realpath(__file__)))
```

注意：在出现同名模块时，可能有问题

### 5. 根据 __name__ 执行不同的引入方式
在`m1a.py`的代码前面，加上：

```python
if __name__ == '__main__':
    from m1b import fb
else:
    from .m1b import fb
```
