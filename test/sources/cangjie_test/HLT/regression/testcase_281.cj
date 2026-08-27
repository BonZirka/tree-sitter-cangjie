/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// RUN-EXEC: %run %run_opt %output  %run_args

let a = b() as c
interface c {}
struct b {
    func d<e>() {}
}
main():Int64{
    b()
    0
}
