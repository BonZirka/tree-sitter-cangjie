/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %stdx-package %f -o %output

import stdx.actors.*
import stdx.actors.macros.*

@Annotation
public class Version {
    let code: String
    const init(code: String) {
        this.code = code
    }
}

@Actor
@Version["1"]
class MyActor {
    @Receiver
    @Version["1"]
    public func foo(): Int64 {
        10
    }
}

main() {
    MyActor().foo()
    0
}