// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix
// ASSERT: regex-not core dump
// ASSERT: regex-not stack trace

enum Unit1 {
    u1_3 | u2_1110 | u1_7
}

enum Unit2 {
    u2_10(Int64)
    | u2_110(Int64, Int64)
    | u2_1110(Int64, Int64, Int64)
    | u2_1110(Int64, Int64, Int64, Int64)
}

enum Unit3 {
    Year3(Int64)
    | Month3(Int64, Int64)
}

func codegenUnitTest(): Int64 {
    var u1 = u2_1110
    var ans1: Int64 = match (u1) { // 3
        case _ => 3
        case u2_1110 => 5
    }
    var u2 = Unit2.u2_1110(10, 100, 1000)
    var u2_ = u2_1110(1, 10, 100, 1000)
    var ans2: Int64 = match (u2) { // 1110
        case u2_10(x) => x
        case u2_110(x, y) => x + y
        case u2_1110(x, y, z) => x + y + z
        case u2_1110(x, y, z, u) => x + y + z + u
    } + match (u2_) { // 1111
        case u2_10(x) => x
        case u2_110(x, y) => x + y
        case u2_1110(x, y, z) => x + y + z
        case u2_1110(x, y, z, u) => x + y + z + u
    }
    var u3_1 = Year3(10000)
    var u3_2 = Month3(100000, 1000000)
    var ans3: Int64 = match (u3_2) { // 1110000
        case Year3(x) => x
        case Month3(x, y) => x + y
    }
    var ans4 = match (u3_1) { // 20000000
        case Year3(100000) => 10000000
        case Year3(10000) => 20000000
        case _ => 30000000
    } + match (u3_2) { // 500000000
        case Month3(1, 10) => 100000000
        case Year3(_) => 200000000
        case Month3(1, _) => 300000000
        case Month3(_, 10) => 400000000
        case Month3(_, _) => 500000000
    }
    return ans1 + ans2 + ans3 + ans4
}

enum Color {
    red
    | custom(String)
}

class Div {
    public func getColor(background: Color) {
        match (background) {
            case red => "red"
            case custom(x) => x
        }
        return 0
    }
}

main(): Int64 {
    var ret = codegenUnitTest()
    if (ret == 521102224) {
        return 0
    } else {
        return -1
    }
}
