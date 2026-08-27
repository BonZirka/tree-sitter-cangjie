/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f





struct A{
    public var a:Int32 = 1
    public let b:Int32 = 1
}

main(): Int64 {

    var x = A()
    x.a = 2
    x.b = 2 

    let y = A()
    y.a = 2  
    y.b = 2 

    var m = B()
    m.a = 2
    m.b = 2 

    let n = B()
    n.a = 2  
    n.b = 2 

    return 0
}

struct B{
    public var a:Int32 = 1
    public let b:Int32 = 1
}
// ASSERT: scan sema_cannot_assign_to_immutable
