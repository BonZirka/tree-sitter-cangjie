// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

let ad0: (Int64, Int64) -> Int64 = {a: Int64, b: Int64 => a + b + 1}
main() {
    let ad1: (Int64, Int64) -> Int64 = {a: Int64, b: Int64 => a + b}
    let ad3 = ad1(1, 2) //expr ad1(1,2)
    0
}
