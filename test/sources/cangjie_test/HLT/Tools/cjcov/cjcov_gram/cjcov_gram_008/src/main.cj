/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

func func1(para: Int64): Int64 {
    var i = 10
    while (para <= i) {
        i--
        if (i == 4) {
            continue
        }
        print(i.toString())
    }
    return i
}

main(): Int64 {
    func1(1)

    return 0
}
