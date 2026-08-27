/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// DEPENDENCE: getPath.sh test_fj.txt
// (not Windows) EXEC: chmod +x getPath.sh
// (not Windows) EXEC: ./getPath.sh b && cat mypath.cj
// (not Windows) EXEC: %compiler %cmp_opt mypath.cj -o %output %f
// (not Windows) RUN-EXEC: %run %run_opt %output %run_args
import std.posix.*

main() {
    var resulttrue1 = isBlk(mypath)
    if (resulttrue1 != true) {
        return 1
    }
    var resultfalse1 = isBlk("test_fj.txt")
    var resultfalse2 = isBlk("./test_notexists")
    if (resultfalse1 != false || resultfalse2 != false) {
        return 2
    }
    return 0
}
