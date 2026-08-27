/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler  %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan 1

class Test <: ToString {
    public var a: ?Int64 = 0

    public func toString() {
        "${a}"
    }
}

main() {
    var b = Test()
    let p: ?(Test, String) = (b, "test")
    match (p) {
        case Some(v) =>
            v[0].a = 1
            println(v[0])
        case _ => ()
    }
}
