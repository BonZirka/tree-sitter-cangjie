/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

class Test {
    public var a: Int32 = 2
    public var b: Int32 = 0
    public init() {}
    public init(x: Int32) {
        this()
        a = a + x
        b = foo(this)
    }
    public func foo(t: Test): Int32 {
        var i = t.a + 1
        return i
    }
}

class Data<T> {
    public var a: T
    public var b: Data<T>
    public init(x: T, y: Int32) {
        a = x
        b = Data<T>(x)
    }
    public init(x: T) {
        this(x, 0)
        b = foo(this)
    }
    public func foo(d: Data<T>): Data<T> {
        return d
    }
}

func run(): Int64 {
    var test: Test = Test(2)
    var data: Data<Int32> = Data<Int32>(3)
    var res1: Int32 = test.b
    var res2: Int32 = data.b.a
    if (res1 == 5 && res2 == 3) {
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
// ASSERT: scan sema_recursive_constructor_call
