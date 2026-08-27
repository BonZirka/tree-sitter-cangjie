// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj -o %n.%suffix

main() {
    var public public = 1
    public var private = 1
    return 0
}

/* SCAN
error: variable declaration 'public' needs either type or initializer
 ==> vardecl_error.cj:5:15:
  | 
5 |     var public public = 1
  |     ~~~~~~~~~~^ expected ':' or '=' after variable name
  | 

error: expected ';' or '<NL>', found keyword 'public'
 ==> vardecl_error.cj:5:16:
  | 
5 |     var public public = 1
  |                ^^^^^^ expected ';' or '<NL>' here
  | 

error: unexpected modifier 'public' on variable declaration in main function body
 ==> vardecl_error.cj:6:5:
  | 
4 | main() {
  | ~~~~ in main function
5 |     var public public = 1
6 |     public var private = 1
  |     ^^^^^^ ~~~ on variable declaration
  |     |
  |     unexpected modifier
  | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
