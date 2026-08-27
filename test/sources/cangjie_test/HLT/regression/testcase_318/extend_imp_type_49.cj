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

type TI = I

interface I{
  func a(a:Rune){a}
}

extend Rune <: TI{
  public func a(a:Rune){a}
}

var a : Rune = r'a'

class classA {
  public mut prop b: Rune {
    get() {
      a 
    }
    set(v) {
      a = Rune(1).a(v)
    }
  }
}

main(): Int64  {
  var x = classA()
  let y = x.b //get
  x.b = r'b' // set
  if(y==r'a' && x.b == r'b'){
    return 0
  }else{
    return 1
 0}
}


