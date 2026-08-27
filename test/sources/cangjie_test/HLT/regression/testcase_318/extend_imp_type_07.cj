/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

type int = Int32
type A =I

interface I{
  static func b():int{
    2
  }
}

extend int <:A{}

var a : (int,int) = (int.b(),int.b())

main(): Int64 {
  if(a[0]-1 == 1 && a[1] == 2){
    return 0
0 }else{
    return 1
  }
}



