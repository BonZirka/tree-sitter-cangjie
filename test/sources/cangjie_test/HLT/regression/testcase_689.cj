/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ./c_def.c
// EXEC: %clang %clang_opt ./c_def.c -o %cffi_output
// EXEC: %compiler %cmp_opt %ffic_opt -o %output
// RUN-EXEC: %run %run_opt %output %run_args

foreign func C_Abort(): Unit

func get_kind(v: Int32): Int32 {
    var k: Int32 = v
    return k
}

func some_call(): Int32 {
    return 0
}

func example(arg: Int32): Unit {
    var tmp: Int32
    var kind: Int32 = get_kind(arg)
    if (kind == 9 || kind == 10 || kind == 5) {
        if (some_call() == 0) {
            if (kind == 9 || kind == 10) {
                tmp = arg
            }
        }
    }
}

main(): Int64 {
    example(10)
    print(0)
    return 0
}
