// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

func test() {
    let lambda1 = {
        => // abc
        if (true) {
            1
        } else {
            2
        }
    }

    match (y) {
        case /*1*/ Some(_) =>
            a()
            b()
            c()
            d()

        case /*1*/ Some(_) => //abc
            54 // abc
    }
}
