/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    match (a) {
        case E1.A0 | E1.B0 => ()
        case E1.A0(1) => ()
        case p1.p0.E<Int64>.A1(1) => ()
        case p1.p0.E<T, U>.B1(a0, b0) =>()
    }
}
