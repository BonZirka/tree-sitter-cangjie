// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// ASEERT: regex-not core dump
// ASEERT: regex-not stack trace


class X<T>{
    public static func test<T> (a:T,b:Int8):Int64{1}
    public static func test<T> (a:T,b:Int16):Int32{2}
@#}
main():Int64{
    X<Int32>.test(1,1)
    return 0
}


/* SCAN
error: expected '#' or '"' in raw string, found '}'
 ==> parser_fuzz_02.cj:9:3:
  | 
9 | @#}
  |  ~^ expected '#' or '"'
  |  |
  |  because it is raw string prefix
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
