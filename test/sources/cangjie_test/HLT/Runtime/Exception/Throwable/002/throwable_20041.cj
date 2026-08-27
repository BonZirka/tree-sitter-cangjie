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

func test(): Int64 {
    var res = 0
    try {
        try {
            throw A()
        } catch (e: B) {
            res = 1
        } finally {
            if (res == 1) {
                throw Exception()
            } else {
                res = 2
            }
        }
    } catch (e: A) {
        if (res == 2) {
            res = 3
        }
    }
    return res - 3
}

main() {
    test()
}
