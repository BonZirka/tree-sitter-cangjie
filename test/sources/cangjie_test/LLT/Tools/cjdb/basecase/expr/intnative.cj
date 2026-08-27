// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

var a = 3
var c: IntNative = 4
func foo(a: IntNative, b: IntNative) {
    return a + b
}
main() {
    foo(1, 2)
}
