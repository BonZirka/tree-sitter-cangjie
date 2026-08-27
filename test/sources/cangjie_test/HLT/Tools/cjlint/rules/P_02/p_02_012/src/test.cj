/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

struct A{
    static var a:Int64 = 0
}

struct B<T> {
    func test<T>() {
        for (i in 0..10) {
            spawn {
                A.a++
            }
        }
        return 0
    }
}

main() {
    return 0
}
