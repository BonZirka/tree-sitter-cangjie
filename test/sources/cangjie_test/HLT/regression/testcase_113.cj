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

type A<T,k> = enumA<T,k>

enum enumA<T,K> {
  B(T) | C(K)
}

extend enumA<Rune,String> {
  public func f(){"%%"}
}

main(): Int64  {
  func a(a:Int64):A<Rune,String>{
 !  if(a>10){
      return A<Rune,String>.B(r'%')
    }else{
      return return A<Rune,String>.C(A<Rune,String>.B(r'%').f())
    }
  }

  func b(b:Int64){
    var c : String = match(a(b)){
      case B(x) => x.toString() 
      case C(y) => y + A<Rune,String>.B(r'%').f()
      case _ => "fail"
    }
    return c
  }

  if( b(10) == "%%%%"){
    return 0
  }else{
    return 1
  }
}


