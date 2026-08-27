// EXEC: %compiler %f -o %output

class Foo {
    static public const a = 100
    static public const b = 200
    static public const c = 300
}
main() {
    println("${Foo.a}, ${Foo.b}, ${Foo.c}")
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
