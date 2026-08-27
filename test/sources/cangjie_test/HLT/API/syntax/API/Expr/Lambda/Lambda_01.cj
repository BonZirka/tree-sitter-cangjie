/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    { => }
    { a: Int64 => a}
    { a: Int64, b: Int64 => a + b + 1}
    { => 100}
    { a => a + 1}
    { _ => return "Hello"}
    { => 
        100
        1+1
        a + b1
        if (true) {}
        return 10
    }
    { => e1; e2 }
}
