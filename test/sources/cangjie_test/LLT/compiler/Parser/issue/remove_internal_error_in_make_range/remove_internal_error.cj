// ERRCHECK: %compiler %cmp_opt %f

var a: Int64 = 5

main() {
    var c = Option<Int64>.None
    return c.pa - 5
}

extend<T> Option<T><: I<T>{
public prop pa: Intn c.pa - 5
}

extend<T> Option<T><: I<T>{
public prop pa: Int64{
    get(){
      a
    }
  }
}

interface I<T>{
  prop pa: Int64{
    get(){
      a
    }
  }
}

/* SCAN
error: expected '{', found 'c'
  ==> remove_internal_error.cj:11:22:
   | 
11 | public prop pa: Intn c.pa - 5
   |                      ^ expected '{' here
   | 
   # note: property declaration must have body

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
