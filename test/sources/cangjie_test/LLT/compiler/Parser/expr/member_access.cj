// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// ASSERT: regex-not core dump

class A {
    var a: Int64 = 1
    var b: Int64 = 2
}

func a(): (Int64,Int64) {
    let a = A()
    a.b = a.a

   (a.b, a.a)
}

main() {
    0
}
