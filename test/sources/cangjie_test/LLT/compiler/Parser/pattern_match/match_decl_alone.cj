// EXEC: %compiler %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main():Int64 {
    let a = 1
    var result = match (a) {
        case _ => var c = 10
    }
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
