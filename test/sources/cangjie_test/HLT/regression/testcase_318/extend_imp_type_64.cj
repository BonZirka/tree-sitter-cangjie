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

type A<T,k> = structA<T,k>

var d = r'#'

extend structA<Rune,String> <:I<Rune,String> {}

interface I<T,K> {
  static mut prop i: Rune {
    get() {
      d 
    }
    set(v) {
      d = v
    }
  }
}

struct structA<T,K> {
  public var a:T
  public var b:K
  public structA( x:T,y:K){
    this.a = x
    this.b = y
  }
}

main(): Int64  {
  func a(a:A<Rune,String>){
    return a.a.toString() + a.b
  }

  A<Rune,String>.i = r'@'

  if(a(A<Rune,String>(A<Rune,String>.i,"345")) == "@345"){
    return 0
 0}else{
    return 1
  }
}



