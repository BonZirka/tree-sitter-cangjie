// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

interface I<T> {
    static func f(a:T): Unit
}

abstract class public <: I<public> {
    public static func f(a:public): Unit {}
}

func g<T>(): Unit where T <: I<T> {}

main() {
    g<public>()
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
