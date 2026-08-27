/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// random seed:1629934375190
// Int64[] -> Array<Int64>, Success -> Ok, Failure -> Err

main(): Int64 {
    func func6<T0>() : Int64 {
        func func55<T0>() : UInt64 {
            return 0
        }

        return 0
    }

    func6<Int64>()

    return 0;
}
