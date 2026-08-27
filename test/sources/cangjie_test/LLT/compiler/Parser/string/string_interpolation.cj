// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f



func run(): Int64 {
    var s:String = "hello"
    var a = "${s${s}}" 
    var b = "${${s}}" 
    print("${s${s}}") 
    print("${${s}}") 
    return 0
}

main(): Int64 {
    return run()
}

/* SCAN
error: expected ';' or '<NL>', found '$'
 ==> string_interpolation.cj:7:17:
  | 
7 |     var a = "${s${s}}" 
  |                 ^ expected ';' or '<NL>' here
  | 

error: expected expression or declaration, found '}'
 ==> string_interpolation.cj:7:21:
  | 
7 |     var a = "${s${s}}" 
  |                     ^ expected expression or declaration here
  | 

error: string interpolation cannot be empty
 ==> string_interpolation.cj:8:14:
  | 
8 |     var b = "${${s}}" 
  |              ^^^^^^^ empty string interpolation
  | 

error: expected expression or declaration, found '$'
 ==> string_interpolation.cj:8:16:
  | 
8 |     var b = "${${s}}" 
  |                ^ expected expression or declaration here
  | 

error: expected ';' or '<NL>', found '$'
 ==> string_interpolation.cj:9:15:
  | 
9 |     print("${s${s}}") 
  |               ^ expected ';' or '<NL>' here
  | 

error: expected expression or declaration, found '}'
 ==> string_interpolation.cj:9:19:
  | 
9 |     print("${s${s}}") 
  |                   ^ expected expression or declaration here
  | 

error: string interpolation cannot be empty
  ==> string_interpolation.cj:10:12:
   | 
10 |     print("${${s}}") 
   |            ^^^^^^^ empty string interpolation
   | 

error: expected expression or declaration, found '$'
  ==> string_interpolation.cj:10:14:
   | 
10 |     print("${${s}}") 
   |              ^ expected expression or declaration here
   | 

8 errors generated, 8 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
