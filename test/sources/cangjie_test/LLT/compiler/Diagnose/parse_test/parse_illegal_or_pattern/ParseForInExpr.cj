// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

internal import p.f1
internal import std.collection.*

main():Int64{
    var array = ArrayList<(Int64,Int64)>();
    for((x |,y) in array){
    }
    return 0
}

/* SCAN
error: '|' is not allowed here
  ==> ParseForInExpr.cj:15:12:
   | 
15 |     for((x |,y) in array){
   |            ^ expected ',' or ')', found '|'
   | 

1 error generated, 1 error printed.
*/
