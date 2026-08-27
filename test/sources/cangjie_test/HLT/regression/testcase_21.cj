/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt  %f -o %output



interface I{
func foo(){
  return 1
}
}

class A{
  public A(var b!:Int32 = 0){

  }
}

extend A <: I{
  public func me(b:Int32): This {
    foo
    return this
  }
}

main(): Int64 {
  return Int64(A().me(3).b)
}
// ASSERT: scan parse_this_type_not_allow


