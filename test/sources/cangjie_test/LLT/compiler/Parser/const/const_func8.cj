// EXEC: %compiler %cmp_opt %f -o %output  2>&1 | compare %f

func test(const n: Int64, const var anno!: Int64 = 1) {
    return n + anno
}

main() {}

/* SCAN
error: unexpected const variable declaration in paramlist
 ==> const_func8.cj:3:11:
  | 
3 | func test(const n: Int64, const var anno!: Int64 = 1) {
  |           ^^^^^ unexpected const variable declaration
  | 

error: expected no modifier before non-member variable parameter, found 'const'
 ==> const_func8.cj:3:27:
  | 
3 | func test(const n: Int64, const var anno!: Int64 = 1) {
  |                           ^^^^^     ~~~~~~~~~~~~~~~~ before non-member variable parameter
  |                           |
  |                           expected no modifier here
  | 
help: if you want an immutable member variable, use 'let':
  | 
3 | func test(const n: Int64, const var let anno!: Int64 = 1) {
  |                                     ~~~~~~~~~~~~~~~~~~~~ 
  | 
help: or 'var' to get a mutable member variable:
  | 
3 | func test(const n: Int64, const var var anno!: Int64 = 1) {
  |                                     ~~~~~~~~~~~~~~~~~~~~ 
  | 

error: expected one parameter name or ')', found keyword 'var'
 ==> const_func8.cj:3:33:
  | 
3 | func test(const n: Int64, const var anno!: Int64 = 1) {
  |                                 ^^^ expected one parameter name or ')' here
  | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
