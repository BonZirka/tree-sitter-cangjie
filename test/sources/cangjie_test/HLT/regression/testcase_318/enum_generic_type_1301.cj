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

enum TimeUnit<T> { Month }

func getValue<T>() : TimeUnit<T> {
    return TimeUnit<T>.Month
}

func run(): Int64 {
    var time = getValue<Int32>()
    var res: Int32 = match (time) {
        case Month => 5
    }  

    if (res == 5) {
        return 0
 0  } else {
        return 1
    }
}

main(): Int64 {
    return run()
}