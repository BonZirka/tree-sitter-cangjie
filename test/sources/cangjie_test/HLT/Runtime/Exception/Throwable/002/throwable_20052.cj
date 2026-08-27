/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class A <: Exception {}

class B <: Exception {}

var count = 0

func test() {
    var i = 0
    while (i != 10) {
        try {
            if (i == 5) {
                throw A()
            }
            if (i == 8) {
                throw B()
            }
        } catch (_: A) {} finally {
            count++
        }
        i++
    }
    return count
}

main() {
    try {
        test()
        ()
    } catch (_: B) {
        if (count != 9) { // 8 + 1 = 9
            return count
        }
    }
    return 0
}
