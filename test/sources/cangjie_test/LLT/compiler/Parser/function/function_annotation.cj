// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f


@FastNative
func test(a:Int64,b:UInt64){
    return a**b
}

func test1(a:Int64,b:UInt64){
    return a**b
}
@FastNative
class A {}
main() {
    return 0
}

/* SCAN
error: non-foreign function cannot be modified with '@FastNative'
 ==> function_annotation.cj:5:1:
  | 
5 | @FastNative
  | ^ 
  | 

error: class cannot be modified with '@FastNative'
  ==> function_annotation.cj:13:1:
   | 
13 | @FastNative
   | ^ 
   | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
