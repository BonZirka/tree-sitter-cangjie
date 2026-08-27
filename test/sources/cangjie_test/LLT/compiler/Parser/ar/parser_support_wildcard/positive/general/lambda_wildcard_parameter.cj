// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output 

main():Int64{
    let lf: (Int64, Int64) -> Int64 = {n, _ => return n * n}
    var rf: (Int64, Int64) -> Int64 = {_, n => return n * n}
    let f: (Int64) -> Int64 = {_ => return 5}
    if (lf(2,3) * rf(2,3) * f(1) == 180){
        return 0
    }
    else {
        return 1
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
