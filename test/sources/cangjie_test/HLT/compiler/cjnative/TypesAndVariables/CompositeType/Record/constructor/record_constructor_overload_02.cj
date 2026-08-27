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

struct Test {
    public var tmp: Int32 = 0
    public init() {}
    public init(x: Int32) {
        tmp = x + 1
    }
    public init(x: Int32, y: Int32) {}
    public init(x: Int32, y: Float64) {}
}

var a: Int32 = 2
let res = Test(a)
var res1 = res.tmp

func run(): Int64 {
    if (res1 == 3) {
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
