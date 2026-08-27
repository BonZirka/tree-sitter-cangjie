
// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

enum a {
 | public(Int64)
 | private(Int64, Int64)
 | protected(Int64, Int64, Int64)
 | redef(Int64, Int64)
}

main() {

 // enumPattern
 let x = match (a.public(1)) {
        case public(1) => 1
        case private(_, 1) => 0
        case protected(1,2, _) => 2
        case redef(_, 10) => 3
        case _=> 4
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
