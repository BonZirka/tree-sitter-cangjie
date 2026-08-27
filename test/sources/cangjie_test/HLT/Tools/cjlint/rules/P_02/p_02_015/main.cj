/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE: %lint -f ./  -c %cangjieDir/tools -m %cangjieDir 2>&1 | compare %f
// ASSERT: scan P.02
// ASSERT: scan the same variable is protected by different mutex

import std.sync.*
var m1 = ReentrantMutex()
var m2 = m1
class A<T> {
    var a = 1
}

extend<T> A<T> {
    func foo() {
        return 1
    }
}
var b =  A<Int64>()
var c = b.a
func temp1() {
    spawn {
        m1.lock()
        c = b.foo()
        m1.unlock()
    }
}

func temp2() {
    spawn {
        m2.lock()
        c = b.foo()
        m2.unlock()
    }
}

main() {
}
