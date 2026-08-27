/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class GenRec1 {
    public let b: Int32 = GenRec2.foo()

    public static func foo(): Int32 {
        return 3
    }
}

public class GenRec2 {
    public let b: Int32 = GenRec1.foo()
    public static func foo(): Int32 {
        return 4
    }
}

main(): Int64 {
    var res1 = GenRec1()
    var res2 = GenRec2()
    if (res1.b == 4 && res2.b == 3) {
        return 0
    }
    return 1
}
