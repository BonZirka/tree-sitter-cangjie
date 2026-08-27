// ERRCHECK: %compiler %cmp_opt %f -o %output

func gfn(fn:(Int64) -> ((Int64) -> Int64) -> Int64): ((Int64) -> Int64) -> Int64 {
    return fn(1)
}

main():Int64{
    let a = Some(gfn);
    let b = a?{_ => return {fn:(Int64) -> Int64 => 0}}{_ => return 0}
    match(b){
        case Some(c) => return c 
        case None => return 1
    }
}

/* SCAN-IN
error: trailing closure can only be used on function calls with function or variable names
 ==> item_after_quest_3.cj:9:13:
  | 
9 |     let b = a?{_ => return {fn:(Int64) -> Int64 => 0}}{_ => return 0}
  |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
