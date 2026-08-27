// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %f %noColor -o %output

public const a = 0 //ok

public const var a = 1 // err
const public let b = 2 // err
const public var (c, d) = (3, 4) // err

const static e = 1 // err
const mut (f, g) = (1, 2) // err

main() {}

/* SCAN
error: unexpected modifier 'const' on var or let variable
  ==> const_variable5.cj:12:8:
   | 
12 | public const var a = 1 // err
   |        ^^^^^ ~~~ 
   |        |
   |        unexpected modifier
   | 

error: unexpected modifier 'const' on var or let variable
  ==> const_variable5.cj:13:1:
   | 
13 | const public let b = 2 // err
   | ^^^^^        ~~~ 
   | |
   | unexpected modifier
   | 

error: unexpected modifier 'const' on var or let variable
  ==> const_variable5.cj:14:1:
   | 
14 | const public var (c, d) = (3, 4) // err
   | ^^^^^        ~~~ 
   | |
   | unexpected modifier
   | 

error: expected declaration, found 'e'
  ==> const_variable5.cj:16:14:
   | 
16 | const static e = 1 // err
   |              ^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found '('
  ==> const_variable5.cj:17:11:
   | 
17 | const mut (f, g) = (1, 2) // err
   |           ^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

5 errors generated, 5 errors printed.
*/
