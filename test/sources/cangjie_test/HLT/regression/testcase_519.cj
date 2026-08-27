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


class A{
  public static var a : Int64 = 5
A(){

}
}
 
extend A {
  static private func ppp(){
 
}
}
 
extend A {
  static private func ppp(){
    return a
  }

  static public func me() {
    return ppp()
  }
}


main(): Int64 {
  return A.me() - 5
}
