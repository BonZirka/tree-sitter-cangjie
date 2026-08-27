/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main(): Int64 {
    var b = Boo()
    return 0
}

struct Boo {
    public var a: Int32 = 1
    public let b: Int32 = 1
    public static var c: Int32 = 1
    public static let d: Int32 = 1
    public mut prop m: Int32 {
        get() {
            return (a + b + c + d)
        }
        set(input) {
            a = input + 1
            c = input + 1
        }
    }

    public func set(input: Int32) {
        a = input + 1
        b = input + 1
        c = input + 1
    }

    public prop n: Int32 {
        get() {
            a++
            c++
            return ((a + b + c + d) * 2)
        }
    }
}
// ASSERT: scan sema_cannot_modify_var
// ASSERT: scan sema_cannot_assign_to_immutable
