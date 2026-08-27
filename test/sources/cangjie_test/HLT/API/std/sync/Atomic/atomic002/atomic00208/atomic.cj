/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC:%compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan in class B1\nin class B2\n
import std.sync.*

interface A {
    func test(): Unit {
        print("in interface A\n")
    }
}

class B <: Object & A {
    public var str: String = ""

    public init(str: String) {
        this.str = str
    }

    public func test(): Unit {
        print(str)
    }
}

main(): Int64 {
    let test = AtomicReference<B>(B("in class B1\n"))
    var cls = test.swap(B("in class B2\n"))
    cls.test()

    let thread: Future<Unit> = spawn {
        var cls = test.swap(B("in class B3\n"))
        cls.test()
    }

    thread.get()
    return 0
}
