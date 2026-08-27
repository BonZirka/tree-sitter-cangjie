// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

var a1: Int32 = 2147483647
var a2: Int32 = 2147483647
var test = @OverflowSaturating{=> func x(){var a : Int8 = 100; a+a};x() }
var a = Array<Int32>(1, @OverflowWrapping{i => a1+a2})
var test = @OverflowThrowing{=> var x = @OverflowSaturating{=> var a : Int8 = 100; a+a};x() }

main(): Int64 {

    return Int64(a[0]+2)
}
