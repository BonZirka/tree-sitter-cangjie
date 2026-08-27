// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

func gfn(fn:(Int64, Int64) -> Int64):Int64{
    return fn(1, 2)
}

main():Int64{
    let a = Some(gfn);
    let b = a?{_,_ => return 0}
    match(b){
        case Some(c) => return c 
        case None => return 1
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
