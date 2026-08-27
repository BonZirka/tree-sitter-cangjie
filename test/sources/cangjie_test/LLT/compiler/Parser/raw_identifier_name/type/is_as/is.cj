// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error

open class `Base` {
    var name: String = "Alice"
}

class `Derived` <: Base {
    var age: UInt8 = 18
}

main() {
    let b1: Base = Base()
    let b2: Base = Derived()
    var x = b1 is Base
    println("Is the type of b1 'Base'? ${x}")
    x = b1 is `Base`
    println("Is the type of b1 '`Base`'? ${x}")
    x = b2 is Derived
    println("Is the type of b2 'Derived'? ${x}")
    x = b2 is `Derived`
    println("Is the type of b2 '`Derived`'? ${x}")
}

/* SCAN
Is the type of b1 'Base'? true
Is the type of b1 '`Base`'? true
Is the type of b2 'Derived'? true
Is the type of b2 '`Derived`'? true
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
