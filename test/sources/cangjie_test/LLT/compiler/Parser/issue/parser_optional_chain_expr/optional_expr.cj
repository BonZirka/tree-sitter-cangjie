// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main() : Int64 {
    let a = Some([1, 4])
    a?[0] <<= 1 
    a?[1] >>= 1
    if (let Some(ar) <- a){
        if (ar[0] != 2){
            return 1
        }
        if (ar[1] != 2){
            return 1
        }
        return 0
    }
    return 1
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
