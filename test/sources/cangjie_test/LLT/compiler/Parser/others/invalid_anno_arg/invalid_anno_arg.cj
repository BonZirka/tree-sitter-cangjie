// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %run_macro %compiler %cmp_opt  %f  -o %output 2>&1 | compare %f




import std.convert.* 
import define.* 

@M[:] 
func test < T >(a: T, b!: Int64 = Int64.parse(1.toString())) { 
    Int64.parse(0.toString()) 
} 
@M[a,] 
class C < T > { } 
@M[:
, :] 
struct R < T > { } 
@M[:
] 
var i: Int64 = Int64.parse(1.toString()) 
main() { 
    C < Int64 >() 
    R < Int64 >() 
    return test < Int64 >(Int64.parse(0.toString()), b: Int64.parse(0.toString())) + i - Int64.parse(1.toString()) 
}

/* SCAN
error: expected expression after '[', found ':'
  ==> invalid_anno_arg.cj:11:4:
   | 
11 | @M[:] 
   |    ^ expected expression here
   | 

error: expected identifier, found ']'
  ==> invalid_anno_arg.cj:15:6:
   | 
15 | @M[a,] 
   |      ^ expected identifier here
   | 

error: expected expression after '[', found ':'
  ==> invalid_anno_arg.cj:17:4:
   | 
17 | @M[:
   |    ^ expected expression here
   | 

error: expected expression after ',', found ':'
  ==> invalid_anno_arg.cj:18:3:
   | 
18 | , :] 
   |   ^ expected expression here
   | 

error: expected expression after '[', found ':'
  ==> invalid_anno_arg.cj:20:4:
   | 
20 | @M[:
   |    ^ expected expression here
   | 

5 errors generated, 5 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
