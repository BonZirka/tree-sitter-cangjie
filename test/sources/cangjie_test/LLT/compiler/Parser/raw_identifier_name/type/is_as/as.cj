// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1
// ASSERT: regex-not error

open class `Base` {
    var name: String = "Alice"
}

class `Derived` <: Base {
    var age: UInt8 = 18
}

main() {
    let b2: Base = Derived()

    let r3 = b2 as Base // r3 = Option<`Base`>.Some(b2)
    let r4 = b2 as Derived // r4 = Option<`Derived`>.Some(b2)
    let r3_1 = b2 as `Base` // r3_1 = Option<`Base`>.Some(b2)
    let r4_1 = b2 as `Derived` // r4_1 = Option<`Derived`>.Some(b2)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
