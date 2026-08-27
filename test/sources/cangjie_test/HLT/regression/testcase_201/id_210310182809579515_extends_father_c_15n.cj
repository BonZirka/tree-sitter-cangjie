/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %f | compare %f


private open class Outer {
open private abstract class Parent {
    public let list0 = [1, 2, 3, 3, 2, 1]
    public let list0 = [1, 2, 3, 3, 2, 1]
    public let list0 = [1, 2, 3, 3, 2, 1]
invar field = 1
'}
class Child <: Parent {}
func )main(): Int64 {in
var child = Child()
    child.field **= 1
    child.field *= 2.3
    child.field /= true
if child.field != 1 { 
return 1
}(
return }0
}inin
    let list0 = [1, 2, 3, 3, 2, 1]
}

// ASSERT: regex-not no position error occurred
