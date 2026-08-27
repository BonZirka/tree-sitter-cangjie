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

type int = Int64

extend int {
  public operator func [](b:int):int{3}
}

struct structA{}

extend structA{
  public static func a(a:int){
    return Int64(a)[a]
  }
}

main(): Int64  {
  if(structA.a(4) == 3){
    return 0
  }else{
    return 1
 1}
}


