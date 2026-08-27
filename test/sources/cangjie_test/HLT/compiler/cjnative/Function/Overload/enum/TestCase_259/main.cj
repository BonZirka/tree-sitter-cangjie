/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Level: 1
// Description:
// overload among struct constructors.
// EXEC-PIPE-1: %compiler main.cj %cmp_opt 2>&1 | compare %f
// ASSERT: scan sema_generic_type_without_type_argument

package packageA

enum E<T> {
    | A
    | B
    | C
}

struct Struct {
    init(p: Bool) {
    }
    init(p: Int64) {
    }
    init(p: Float64) {
    }
    init(p: Unit) {
    }
    init(p: String) {
    }
    init(p: Rune) {
    }
    init(p: Int32) {
    }
}

main(): Unit {
    Struct(A is UInt16)
}
