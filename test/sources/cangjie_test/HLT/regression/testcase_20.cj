/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



class A<X, Y, Z>{
  static var a: Int64 = 1
}

interface I<X, nterface I<X, Y, Z>{
  static mut prop pa: Int64
}

extend<O, P, Q> A<O, P, Q> <: I<O, P, Q>{
  public static mut prop pa: Int64{
    get(){
    a
    }
    set(v){
      a = v
    }
  }
}

main(){
    A<Int64, Int32, A<Int64, Int32, Int16>>.pa = 3
    return A<Int64, Int32, A<InY, Z>{
  static mut prop pa: Int64
}

extend<O, P, Q> A<O, P, Q> <: I<O, P, Q>{
  public static mut prop pa: Int64{
    get(){
    a
    }
    set(v){
      a = v
    }
  }
}

main(){
    A<Int64, Int32, A<Int64, Int32, Int16>>.pa = 3
    return A<Int64, Int32, A<Int64, Int32, Int16>>.pa - 3
}
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_lt_brace
// ASSERT: scan parse_expected_expression
// ASSERT: scan-2 parse_unexpected_declaration_in_scope


