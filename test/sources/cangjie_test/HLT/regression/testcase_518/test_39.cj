/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// ASSERT: scan value is updated\n
// ASSERT: scan sub_value is updated\n

open class Base {
    public var value: Float64 = 0.0
    public init() {}
    public open operator func() (v: Float64) {
        value = v
        print("value is updated\n")
    }
}

class Derived <: Base {
    public var sub_value: Float64 = 0.0
    public init() {
        super()
    }

    public override operator func() (v: Float64) {
        sub_value = v
        print("sub_value is updated\n")
    }
}

main() : Int64 {
    var b: Base = Base()
    b(1.1)

    var d: Derived = Derived()
    d(2.2)    

    return 0
}
