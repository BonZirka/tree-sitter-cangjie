// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f
main():Int64{
    return run()
}

func run(): Int64 {
    var x:Int32 = 1
    var res: String  = f(x,) 
    if (res =="12"){
        return 0
    }
    return 1
}

func f(x:Int32,y:Int32=2) :String{
    var a:Int32 = x
    var b:Int32 = a
    var c :String= y.toString()
    return b.toString()+c
}


/* SCAN
error: expected ',' or ')', found '='
  ==> call.cj:15:23:
   | 
15 | func f(x:Int32,y:Int32=2) :String{
   |                       ^ expected ',' or ')' here
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
