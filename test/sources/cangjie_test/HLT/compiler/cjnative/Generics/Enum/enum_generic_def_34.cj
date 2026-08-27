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

enum TimeUnit<T1, T2, T3> {
    Year(T1) | Year(T1, T2) | Year(T1, T2, T3)
}

func run(): Int64 {
    var year1 = TimeUnit<Int32, Int64, String>.Year(1)
    var year2 = TimeUnit<Int32, Int64, String>.Year(1, 2)
    var year3 = TimeUnit<Int32, Int64, String>.Year(1, 2, "3")

    var res1: String = match (year1) {
        case Year(x) => x.toString()
        case Year(x, y) => x.toString() + y.toString()
        case Year(x, y, z) => x.toString() + y.toString() + z
    }
    var res2: String = match (year2) {
        case Year(x) => x.toString()
        case Year(x, y) => x.toString() + y.toString()
        case Year(x, y, z) => x.toString() + y.toString() + z
    }
    var res3: String = match (year3) {
        case Year(x) => x.toString()
        case Year(x, y) => x.toString() + y.toString()
        case Year(x, y, z) => x.toString() + y.toString() + z
    }

    if (res1 == "1" && res2 == "12" && res3 == "123") {
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
