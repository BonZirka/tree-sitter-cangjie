// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

func f(x:Int32->):Unit{

}
main() {

}

/* SCAN
error: type before arrow of function type should be surrounded by parentheses
  ==> funcParam.cj:10:10:
   | 
10 | func f(x:Int32->):Unit{
   |          ^^^^^ 
   | 
help: should be surrounded by '(' and ')':
   | 
10 | func f(x:(Int32)->):Unit{
   |          ~~~~~~~ 
   | 

error: unclosed delimiter: '('
  ==> funcParam.cj:10:15:
   | 
10 | func f(x:Int32->):Unit{
   |       ~       ^ expected ')' here
   |       |
   |       to match this opening '('
   | 

error: expected ';' or '<NL>', found '->'
  ==> funcParam.cj:10:15:
   | 
10 | func f(x:Int32->):Unit{
   |               ^^ expected ';' or '<NL>' here
   | 

3 errors generated, 3 errors printed.
*/
