/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@p1.M1[tok1](var a = 1)

@M2[a: tok1, b: tok2](var a = 1)

@M3(func foo() {})

@M2[a: tok1, b: tok2]
@M3(
class C1 {}
)