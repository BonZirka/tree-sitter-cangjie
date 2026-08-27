// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// EXEC: %run %run_opt %output %run_args

struct B {
    var b = 1
    static func getValue() {
        return B()
    }
    public operator func +(input: B) {
        return B()
    }
}

struct A {
    var d = B()
}

struct C {
    var a = A()
}

main() {
    var c = C()
    c.a.d += B.getValue()
}
