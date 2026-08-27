/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: test_fj.txt test_fj_notnull.txt
// (not Windows) EXEC-PIPE: %compiler %cmp_opt -o %output %f
// (not Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args
import std.posix.*

main(): Int64 {
    var res1 = lchown("test_fj.txt", UInt32(0), UInt32(0))
    var res2 = lchown("test_fj_notnull.txt", UInt32(0), UInt32(0))
    var res3 = lchown("test_fj1.txt", UInt32(0), UInt32(0))
    var res4 = lchown("", UInt32(0), UInt32(0))

    if (res1 != Int32(0) && res1 != Int32(-1) && res2 != Int32(0) && res2 != Int32(-1) && res3 != Int32(-1) && res4 !=
        Int32(-1)) {
        return 1
    }
    return 0
}
