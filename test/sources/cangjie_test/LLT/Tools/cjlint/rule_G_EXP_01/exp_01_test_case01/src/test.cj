// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

let NUM = 20
var result: String = match(NUM) {
    case 10 => "First Case"
    case n: Int64 => "Second Case"
    case _ => ""
}

main() {
    println(result)
}