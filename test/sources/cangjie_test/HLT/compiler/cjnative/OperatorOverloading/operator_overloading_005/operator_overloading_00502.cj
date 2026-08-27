/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// ERRCHECK: %compiler %cmp_opt %f -o %output

interface update {
    operator func [](b: update): update
    operator func !(): update
    //    operator func +(a:update):update
    operator func -(): update
    operator func **(b: update): update
    operator func *(b: update): update
    operator func /(b: update): update
    operator func %(b: update): update
    operator func +(b: update): update
    operator func -(b: update): update
    operator func <<(b: update): update
    operator func >>(b: update): update
    operator func <(b: update): update
    operator func <=(b: update): update
    operator func >(b: update): update
    operator func >=(b: update): update
    operator func ==(b: update): update
    operator func !=(b: update): update
    operator func &(b: update): update
    operator func ^(b: update): update
    operator func |(b: update): update
    //     operator func ^^(b:update):update

}

extend UInt32 <: update {
    public operator func [](b: UInt32): UInt32 {
        1
    }
    public operator func !(): UInt32 {
        5
    }
    //    operator func +(a:UInt32):UInt32   {6}
    public operator func -(): UInt32 {
        7
    }
    public operator func **(b: UInt32): UInt32 {
        8
    }
    public operator func *(b: UInt32): UInt32 {
        9
    }
    public operator func /(b: UInt32): UInt32 {
        10
    }
    public operator func %(b: UInt32): UInt32 {
        11
    }
    public operator func +(b: UInt32): UInt32 {
        13
    }
    public operator func -(b: UInt32): UInt32 {
        14
    }
    public operator func <<(b: UInt32): UInt32 {
        17
    }
    public operator func >>(b: UInt32): UInt32 {
        18
    }
    public operator func <(b: UInt32): UInt32 {
        19
    }
    public operator func <=(b: UInt32): UInt32 {
        20
    }
    public operator func >(b: UInt32): UInt32 {
        21
    }
    public operator func >=(b: UInt32): UInt32 {
        22
    }
    public operator func ==(b: UInt32): UInt32 {
        23
    }
    public operator func !=(b: UInt32): UInt32 {
        24
    }
    public operator func &(b: UInt32): UInt32 {
        25
    }
    public operator func ^(b: UInt32): UInt32 {
        26
    }
    public operator func |(b: UInt32): UInt32 {
        27
    }
    //     operator func ^^(b:UInt32):UInt32  {28}

}

main(): Int64 {
    return 1
}
// ASSERT: scan sema_need_member_implementation
// ASSERT: scan sema_operator_overload_built_in_unary_operator
// ASSERT: scan sema_operator_overload_built_in_binary_operator
// ASSERT: scan sema_return_type_incompatible
