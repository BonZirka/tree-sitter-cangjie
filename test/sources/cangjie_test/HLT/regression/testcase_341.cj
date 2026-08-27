// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


class A<T> {
  public var b: Int32
  public A(b!: Int32 = 0){
    this.b = b
  }
}

interface I<T>{
  static func foo(){
    
  }
}

extend<T> A<T> <: I<T>{
  static public func me<T-PIPE-1: %compiler %cmp_opt %compile_lib_opt %n.cj -o %output 2>&1 | compare %f



class A<T> {
  public var b: Int32
  public A(b!: Int32 = 0){
    this.b = b
  }
}

interface I<T>{
  static func foo(){
    
  }
}

extend<T> A<T> <: I<T>{
  static public func me<T>() {
    return this.b 
  }

  static prop c: Int32 {
    get(){
      this.b 
    }
  }
}

main(): Int64 {
  return 1
}

/* SCAN-IN
error: non-static variable 'this' cannot be referenced from a static context
  ==> invoke_static_func_15_generic.cj:20:12:
   | 
20 |     return this.b 
   |            ^ 
   | 

error: non-static variable 'this' cannot be referenced from a static context
  ==> invoke_static_func_15_generi>() {
    return this.b 
  }

  static prop c: Int32 {
    get(){
      this.b 
    }
  }
}

main(): Int64 {
  return 1
}
// ASSERT: scan lex_unterminated_block_comment

/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 