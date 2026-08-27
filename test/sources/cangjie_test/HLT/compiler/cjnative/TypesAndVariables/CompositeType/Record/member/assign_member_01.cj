/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// ERRCHECK: %compiler %cmp_opt %f -o %output

struct Test {
    public let a: Int32 = 0
    public var b: Int32 = 0
    public static var b2: Int32 = 0
    public func foo(): Int32 {
        return a
    }

    public static func foo1(): Int32 {
        return 0
    }
}

let test = Test()

func run(): Int64 {
    test.a = 1
    test.b = 1
    test.foo = {
        => return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
// ASSERT: scan sema_cannot_assign_to_immutable
// ASSERT: scan sema_unqualified_left_value_assigned
