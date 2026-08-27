/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 |compare %f

var aa = 0

main(): Int64 {
    var a = Data(a: 8).f2()
    if (a is Data && aa == 1 && a.a == 8) {
        return 0
    }
    return 1
}

class Data {
    public Data(var a!: Int64 = 6) {
        aa++
    }

    public func f2(): This {
        return f2(2)
    }

    public func f2(a: Int64): Data {
        return this
    }
}
// ASSERT: scan sema_mismatched_types
