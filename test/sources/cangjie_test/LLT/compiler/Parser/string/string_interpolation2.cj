// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f


main() {
    let arr: Array<Int64> = [3,1,45,12,9]
    let s = arr.size
    var i = 0
    for (e in arr where (i < 1)){
        println("i:${}")
        i++
    }
    return i--
}

/* SCAN
error: string interpolation cannot be empty
 ==> string_interpolation2.cj:9:20:
  | 
9 |         println("i:${}")
  |                    ^^^ empty string interpolation
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
