---
title: 剑指offer笔记
tags:
  - Hexo
categories:
  - Life
date: 2022-05-29 02:11:41
---

### 3 数组中的重复数字
除了时间复杂度，还要考虑空间复杂度，是否可以在原地计算。
注意这种赋值有问题：
nums[i],nums[nums[i]] = nums[nums[i]],nums[i]
这里nums[i]先被赋值，导致nums[nums[i]]的索引已经发生了改变。
正确方式应该使用临时变量，或后赋值nums[i],这样做：
nums[nums[i]],nums[i] = nums[i],nums[nums[i]] 