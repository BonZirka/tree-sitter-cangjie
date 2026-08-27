// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f -o %output
// EXEC: %run %run_opt %output

main() {
    var a = 1
    match (a) {
        case v: Int64 where a > 2 => return 1
        case v where a < 1 => return 2
        case _ => return 0
    }
}
