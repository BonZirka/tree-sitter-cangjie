/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// 更加复杂的循环依赖
// 涉及到单个注解类内部的多个构造函数之间的循环依赖。

@Annotation
public class A0 {
    @A0[12]
    public const init() {}
    @A0['a', 1.2]
    public const init(p0: Int64) {}
    @A0[(), 2.3, 'b']
    public const init(p0: Rune, p1: Float32) {}
    public const init(p0: Unit, p1: Float64, @A0 p2: Rune) {}
}

main() {}

/**
error: recursive constructor calling detected
 ==> ./tmp.cj:7:18:
  |
7 |     public const init() {}
  |                  ^^^^
  |
note: depends on
 ==> ./tmp.cj:6:6:
  |
6 |     @A0[12]
  |      ^^
  |
note: depends on
 ==> ./tmp.cj:9:18:
  |
9 |     public const init(p0: Int64) {}
  |                  ^^^^
  |
note: depends on
 ==> ./tmp.cj:8:6:
  |
8 |     @A0['a', 1.2]
  |      ^^
  |
note: depends on
  ==> ./tmp.cj:11:18:
   |
11 |     public const init(p0: Rune, p1: Float32) {}
   |                  ^^^^
   |
note: depends on
  ==> ./tmp.cj:10:6:
   |
10 |     @A0[(), 2.3, 'b']
   |      ^^
   |
note: depends on
  ==> ./tmp.cj:12:18:
   |
12 |     public const init(p0: Unit, p1: Float64, @A0 p2: Rune) {}
   |                  ^^^^
   |
note: depends on
  ==> ./tmp.cj:12:47:
   |
12 |     public const init(p0: Unit, p1: Float64, @A0 p2: Rune) {}
   |                                               ^^
   |
note: depends on
 ==> ./tmp.cj:7:18:
  |
7 |     public const init() {}
  |                  ^^^^
  |
 */
