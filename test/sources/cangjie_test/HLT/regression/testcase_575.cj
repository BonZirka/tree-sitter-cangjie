/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


open class Parent {
    init() {
        inner_setup()
    }
    func inner_setup() {
        setup()
    }
    protected open func setup() {
        println("=== call Parent.setup()")
    }
}

open class Child <: Parent {
    let intValue: Int64
    let strValue: String
    init(intValue: Int64, strValue: String) {
        super()
        this.intValue = intValue
        this.strValue = strValue
    }
    protected override func setup() {
        println("=== call Child.setup()")
        println(">>> access .intValue: ${intValue}")
        println(">>> access .strValue: ${strValue}")
    }
}

main() {
    let child = Child(100, "cangjie")
}
// ASSERT: scan sema_illegal_member_used_in_open_constructor


