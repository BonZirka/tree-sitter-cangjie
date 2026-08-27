// EXEC:%frontendCompiler %cmp_opt %dump-parse %f 2>&1 > %redirectNull | compare %f



struct Test2 {
    public let width: Int32 = 2
    public let length: Int32 = 5
    public init
    public init(
}

/* SCAN
error: body of constructor is missing
 ==> record1.cj:8:16:
  | 
8 |     public init
  |                ^ missing constructor body here
  | 

error: expected '(' or '<', found keyword 'public'
 ==> record1.cj:9:5:
  | 
9 |     public init(
  |     ^^^^^^ expected '(' or '<' here
  | 

error: unclosed delimiter: '('
 ==> record1.cj:9:17:
  | 
9 |     public init(
  |                ~^ expected ')' here
  |                |
  |                to match this opening '('
  | 

error: expected a argument name after '(' in parameter list, found '}'
  ==> record1.cj:10:1:
   | 
9  |     public init(
   |                ~ after '(' in parameter list
10 | }
   | ^ expected a argument name here
   | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
