/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan close!success!
import std.collection.*

class A <: Resource {
    public func isClosed():Bool {
        false
    }
    public func close():Unit {
        print("close!")
    }
}

var x: ?ArrayList<A> = ArrayList<A>([A()])

main() {
    try (a = A()) {
        x?[0] ?? A()
    } catch (_) {
        x?[0] ?? A()
    } finally {
        x?[0] ?? A()
    }
    print("success!\n")
    return 0
}
