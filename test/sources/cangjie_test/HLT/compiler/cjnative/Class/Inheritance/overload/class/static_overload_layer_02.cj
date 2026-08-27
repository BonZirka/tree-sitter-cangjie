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

abstract class Base {
    public func foo(): Int64
}

abstract class Base1 <: Base {
    public func foo(): Int64
}

abstract class Base2 <: Base1 {
    public func foo(): Int64
}

abstract class Base3 <: Base1 {
    public func foo(): Int64
}

class Data <: Base3 {
    public func foo() {
        return 1
    }

    public func foo(a: Int64) {
        return a
    }

    public func inside() {
        func a() {
            foo() + foo(2)
        }
        a()
    }
}

main(): Int64 {
    var res1: Int64 = Data().foo()
    var res2: Int64 = Data().foo(2)
    var res3: Int64 = Data().inside()
    if (res1 != 1 || res2 != 2 || res3 != 3) {
        return 1
    }
    return 0
}
