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

struct Test1 {
    public func foo(): Int32 {
        return 1
    }
    public init() {}
}

struct Test2 {
    public var b: () -> Int32 = Test1().foo
    public init() {}
}

let res = Test2().b()

func run(): Int64 {
    if (res == 1) {
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
