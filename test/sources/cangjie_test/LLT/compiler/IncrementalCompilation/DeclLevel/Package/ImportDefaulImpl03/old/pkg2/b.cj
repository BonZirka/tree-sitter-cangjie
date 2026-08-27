package pkg2

internal import pkg1.*

class A <: I<Int32> {
}

public func foo<T>() : Int64 {
    var a : A = A()
    I<Int32>.test()
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
