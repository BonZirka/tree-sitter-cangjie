// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

class A {
    var v = 0
    protected var v1 = 1
    private var v2 = 2

    func f() {}
}

extend A {
    // func f() {} //error f()是被扩展类型的成员，不能不能遮盖
}

main() {}
