/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: filterLogic.cj
// EXEC: %compiler %cmp_opt %f filterLogic.cj -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.convert.*
internal import std.collection.*

main(): Int64 {
    var map1 = HashMap<Int64, String>([(1, "one"), (2, "two"), (5, "three")])
    var filterFunc = filter<(Int64, String)>({
        m: (Int64, String) => if (m[0] > 4) {
            return true
        } else {
            return false
        }
    })
    var actualResult01 = filterFunc(map1)
    var iteratorActual01 = actualResult01.iterator()
    var elementActual1 = iteratorActual01.next().getOrThrow()
    if (elementActual1[0] != 5 || elementActual1[1] != "three") {
        return 1
    }
    return 0
}
