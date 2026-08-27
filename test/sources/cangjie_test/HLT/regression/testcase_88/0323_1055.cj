/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f




struct B{
    public var a:Int32 = 1
    public let b:Int32 = 1
}

main(): Int64 {
    A().a = 2
    A().b = 2 
    B().a = 2 
    B().b = 2 
    return 0
}

class A{
    public var a:Int32 = 1
    public let b:Int32 = 1
}
// ASSERT: scan sema_cannot_assign_to_immutable
