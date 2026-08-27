// EXEC: %compiler %cmp_opt %n.cj -o %output
// EXEC: %run %run_opt %output %run_args

func f(a: Int64, fn: (Int64)->Int64) {
    fn(a) 
}

main() {
    f(1, { i => i * i }) // normal function call
    f(1) { i => i * i } // trailing closures
    0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
