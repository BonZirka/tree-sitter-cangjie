// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// REGION: 13:13
/**
 * Created on 2025/09/08
 */
const CONST_VAR = 2
class A {
    func foo<T>(a: T):                    Unit where T <: ToString {
        println("${a}"                     )
        var a1 =                     CONST_VAR
    }
}

main() {}