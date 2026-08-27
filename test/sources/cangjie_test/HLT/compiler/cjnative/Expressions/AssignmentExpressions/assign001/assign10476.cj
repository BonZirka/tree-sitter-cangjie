/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args
class LA {
    public var a: Array<Unit>
    public init(a: Unit) {
        this.a = [a]
    }
}

main(): Int64 {
    var l_a = LA(())
    var r_a: Int32 = 1
    l_a.a[0] = r_a++
    if (l_a.a[0] == ()) {
        return 0
    }
    return 1
}
