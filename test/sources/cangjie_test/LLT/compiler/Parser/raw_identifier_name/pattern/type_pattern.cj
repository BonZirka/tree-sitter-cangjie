// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

class `Base` {
    var a: Int64
    public init() {
        a = 10
    }
}

main() {
    let x = Base()
    let y = match (x) {
        case b: Base => "${b.a}" // Matched.
        case _ => "unknow"
    }
    println(y)
    let z = match (x) {
        case b: `Base` => "${b.a}" // Matched.
        case _ => "unknow"
    }
    println(z)
}

/* SCAN
10
10
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
