// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %n.cj %disableReflection --module-name="ohos" -o %n.%suffix
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_args | compare %f
// ASSERT: scan 10001\n
// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace

package ohos.base

let N = 10000

class MainThreadContext <: ThreadContext {
    public func end(): Unit {}
    public func hasEnded(): Bool {
        false
    }
    func getSchedulerHandle(): CPointer<Unit> {
        CPointer<Unit>()
    } // inner implement
}

func foo() {
    let context = MainThreadContext()
    let a = spawn (context) {
        println(1 + N)
    }
    a.get()
}

main() {
    foo()
    0
}
