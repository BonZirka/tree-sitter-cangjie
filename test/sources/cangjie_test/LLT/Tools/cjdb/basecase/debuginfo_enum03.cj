// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// enum with arg
class A {
    var a = 10
}

enum E1 {
    B(A) | B(A, Int64) | B(A, Int64, String)
}

main() {
    var x = E1.B(A())
    var y = E1.B(A(), 50)
    var z = E1.B(A(), 50, "hhh")
    0
}
