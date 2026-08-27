// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

func test_class<T>(para: T) {
    var d = Cls<T>(para)
    var c = Option<T>.None
    return 0
}

struct Cls<T> {
    var a: T
    var b = 999
    init(para: T) {
        a = para
    }
}

main(): Int64 {
    test_class<Int64>(50)
    0
}
