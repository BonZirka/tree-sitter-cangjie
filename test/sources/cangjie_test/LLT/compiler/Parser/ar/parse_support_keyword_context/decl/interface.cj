// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

interface public<X> {
    static func private(): Int64 {
        return 0
    }
}
class Test<X> <: public<X> {}
main() {
    return Test<Int64>.private()
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
