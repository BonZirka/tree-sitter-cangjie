/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

class Foo {
    private var aZero = 0
    public mut prop abc: Int64 {
        get() {
            println("get")
            aZero
        }
        set(value) {
            println("set")
            aZero = value
        }
    }
}

main() {
    0
}

