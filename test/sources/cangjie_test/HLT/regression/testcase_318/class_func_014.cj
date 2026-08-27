/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args


abstract class Base {
    public static func get() : Int32 {
        return 1
    }
}

func run(): Int64 {
    if (Base.get() != 1) {
        return 1
0   } else {
        return 0
    }
}

main(): Int64 {
    return run()
}
