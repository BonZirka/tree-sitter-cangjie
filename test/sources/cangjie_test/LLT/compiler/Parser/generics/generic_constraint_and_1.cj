// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

open class C {}

interface Tr {}

class D <: C {}

extend D <: Tr {}

func foo<T>(a: T) where T <: C & Tr & D {
}

main(): Int64 {
    foo<D>(D())
    return 0
}
