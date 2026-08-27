/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// ASSERT: scan sema_upper_bound_must_be_class_or_interface

main(): Int64 {
    if (B<Base>().a != "abc") {
        return 2
    }
    return 0
}

class B<T> where T <: Base {
    public var b: String = ""
    public prop a: String {
        get() {
            return T.b
        }
    }
}

struct Base {
    public static var b: String = "abc"
}
