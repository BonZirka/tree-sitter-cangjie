/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Level: 1
// Description:
// overload among interface instance member functions.
// EXEC-PIPE-1: %compiler main.cj %cmp_opt 2>&1 | compare %f
// ASSERT: scan sema_generic_type_without_type_argument

package packageA

enum E<T> {
    | A
    | B
    | C
}

interface Interface {
    func f(p: Bool) {
    }

    func f(p: Int64) {
    }

    func f(p: Float64) {
    }

    func f(p: Unit) {
    }

    func f(p: String) {
    }
}

class ChildClass <: Interface {}

main(): Unit {
    ChildClass().f(A is Float32)
}
