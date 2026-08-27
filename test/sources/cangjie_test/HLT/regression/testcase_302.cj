/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


open class A { 
    public var s1: UInt32 = 1 
} 
class B <: A { 
    public var b1: UInt32 = 2
    public var obj: A = B()
}
main() {
    var c:B=B()
    0
}
// ASSERT: scan sema_recursive_constructor_call


