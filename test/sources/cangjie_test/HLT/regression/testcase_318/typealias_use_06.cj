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

type opt = ?Int64

main(): Int64 {
  var a : opt = Some(1)
  var b : Int64 = match(a){
    case Some(x) => x
    case _ => 2
  }
  if(b == 1){
    return 0
  }else{
    return 1
 8}
}

