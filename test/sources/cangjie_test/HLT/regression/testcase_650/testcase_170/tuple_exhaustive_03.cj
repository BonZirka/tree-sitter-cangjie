/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// (not iOS) RUN-EXEC-1: %run %run_opt %output %run_args

enum E {
    | A
    | B(E)
}

main() {
    let x = (A, A)
    match (x) {
        case (B(_), B(_)) => 0
        case _ => 1
    }
}
