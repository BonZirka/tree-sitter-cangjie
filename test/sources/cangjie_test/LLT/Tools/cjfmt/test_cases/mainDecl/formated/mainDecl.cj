// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main() {
    var a = 1
    if (1 == 0) {
        a
    } else {
        if (1 > 0) {
            var parent = 1
            if (!parent) {
                parent = 2
            }
        }
    }
    return 0
}
