// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main() {
    var a = 0
    var b = 0
    do {
        a++
        if (a == 2) {
            continue
        }
        b += a
        if (b > 5) {
            break
        }
    } while (a < 10)
    0
}