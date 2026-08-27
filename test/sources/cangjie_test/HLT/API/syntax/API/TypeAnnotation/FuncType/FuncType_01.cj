/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

var a1: (a: Int64) -> Unit = foo1
var a2: (Int64, Int64) -> B = foo2
var a3: () -> (A, B) = foo3
var a4: (a: A, b: B) -> () -> Unit = foo4
var a5: (A, B) -> (A, () -> Unit) = foo5
var a6: (a: (A) -> Unit, b: (Int64) -> Unit) -> (A, () -> Unit) = foo6
