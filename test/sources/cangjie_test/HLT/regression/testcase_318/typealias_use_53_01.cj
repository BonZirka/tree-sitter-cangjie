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

class classA<T>{
  public var a:T
  public init(i:T){
    a=i
  }
}

class classB{
  public func a(a:Int64):Int64{a}
}

type B = classB
type A = classA<B>  

main(): Int64 {
  var x: A = A(B())  
  if(x.a.a(1)==1){
    return 0
  }else{
    return 1
8 }
}



