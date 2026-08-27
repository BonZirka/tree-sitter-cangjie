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

type A = classA

extend A{
  public operator func +(b:A):Int64{0}
}

class classA{
  public var a = 1
}

class classB{}

extend classB{
  public func a(a:A){
    return a
  }
}

main(): Int64  {
  print((classB().a(A()) + classB().a(A())).toString())
  if(classB().a(A()) + classB().a(A()) == 0){
    return 0
  }else{
    return 1
  2}
}


