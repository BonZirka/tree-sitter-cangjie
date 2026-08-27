// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args

struct S {
    private func f0() { 0 }
    internal func f1() { 1 }
    protected func f2() { 2 }
    public func f3() { 3 }
    private static func f4() { 4 }
    internal static func f5() { 5 }
    protected static func f6() { 6 }
    public static func f7() { 7 }
    private prop x0: Int64 { get() { 0 } }
    internal prop x1: Int64 { get() { 1 } }
    protected prop x2: Int64 { get() { 2 } }
    public prop x3: Int64 { get() { 3 } }
    private static prop x4: Int64 { get() { 4 } }
    internal static prop x5: Int64 { get() { 5 } }
    protected static prop x6: Int64 { get() { 6 } }
    public static prop x7: Int64 { get() { 7 } }
}

enum E {
    A
    private func f0() { 0 }
    internal func f1() { 1 }
    protected func f2() { 2 }
    public func f3() { 3 }
    private static func f4() { 4 }
    internal static func f5() { 5 }
    protected static func f6() { 6 }
    public static func f7() { 7 }
    private prop x0: Int64 { get() { 0 } }
    internal prop x1: Int64 { get() { 1 } }
    protected prop x2: Int64 { get() { 2 } }
    public prop x3: Int64 { get() { 3 } }
    private static prop x4: Int64 { get() { 4 } }
    internal static prop x5: Int64 { get() { 5 } }
    protected static prop x6: Int64 { get() { 6 } }
    public static prop x7: Int64 { get() { 7 } }
}

main() {}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
