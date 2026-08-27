// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c.cj
// EXEC-0: %compiler %noColor --experimental c/c.cj --output-type=chir --output-dir ./c
package cmp

common struct A {
    common mut prop testProp: Unit {
        get() {
            println("common")
        }
        set(v) {
            println("common")
        }
    }
    init() {}
}

// SEPARATE-FILE: p/p.cj
// ERRCHECK: %compiler %diag_json --experimental p/p.cj --common-part-chir=c/cmp.chir --common-part-cjo=./c/cmp.cjo -o %output
// ASSERT: scan sema_property_have_same_declaration_in_inherit_mut
package cmp

specific struct A {
    specific prop testProp: Unit {
        get() {
            println("specific")
        }
    }
}

main() : Unit {
    A().testProp
}
