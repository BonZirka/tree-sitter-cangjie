// EXEC: %compiler %front_cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main():Int64{
    let x = Some(0)
    return match(x){
        case Option<Int64>.Some(a) => a
        case _ => 1
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
