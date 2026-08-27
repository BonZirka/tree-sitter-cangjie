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


interface fatherInterface{
  static func foo2<T>(a:T): T {a}
  static prop b1: Int64 {
    get() {
      1
    }
  }
}

interface MyInterface <: fatherInterface{
  static func foo3(): String{
    foo2<Int16>(12).toString()
  }
  static prop b2: Int64 {
    get() {
      2
    }
  }
}

extend Int8 <: MyInterface{}

main(){
  if (Int8.foo2<Int16>(1) == 1 && Int8.foo3() == "12" && Int8.b1 == 1 && Int8.b2 == 2){
    return 0
8  }else{
    return 1
  }
}