/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
type A<T> = interfaceA<T>

interface interfaceA<T>{
  func a (a:T){a}
}

class B<T>{}

interface I<T>{
  operator func +(a:A<T>){0}
}

extend<T> B<T> <: A<T>{
  public func a (a:T){a}
}

extend<T> B<T> <: I<T>{
  public operator func +(a:A<T>){0}
}

main(): Int64  {
  if(B<Float64>().a(1.005) == 1.005 && B<Float64>()+B<Float64>() == 0){
    return 0
  }else{
    return 1
  }
}




