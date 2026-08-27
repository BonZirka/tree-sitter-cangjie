/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
import test_stable_abi.*

class C1 <: I1 {}
class C2 <: I7 {}
main() {
    if (I1.g() + I6.g() + I7.g() + I8.g() + f() + C1.g() + C2.g() == 10) {
        0
    } else {
        1
    }
}
