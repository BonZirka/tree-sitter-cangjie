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
//failure cause: octal num is not supported for now
main(): Int64 {
    var a: Int8 = 0o30
    var b: Int8 = 0
    var c: Int8 = 96
    var d: Int8 = 0
    var e: Int8 = 12
    b = a << 2
    if (b != c) {
        return 1
    }
    d = a >> 1
    if (d != e) {
        return 1
    }
    return 0
}
