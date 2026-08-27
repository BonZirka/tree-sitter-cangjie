// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f




main() : Int64 {
    var a:Int8 = 1

    if ( !(a == 'a')){
        return 1
    }
    if ( a == 'b' ){
        return 2
    }
    return 0
}

extend Int8 {
    public operator func ==(right:Rune)(right:Rune):Bool {
        if (right == 'a') {
            return true
        }else{
            return false
        }
    }
}

/* SCAN
error: expected '{', found (
  ==> currying_func_not_support.cj:19:40:
   | 
19 |     public operator func ==(right:Rune)(right:Rune):Bool {
   |                                        ^ expected '{' here
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
