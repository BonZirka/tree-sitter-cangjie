// ERRCHECK:%frontendCompiler %cmp_opt %f

main():Unit{
    var main = 1
}

/* SCAN
error: expected identifier or pattern after 'var', found keyword 'main'
 ==> main_as_identifier.cj:4:9:
  | 
4 |     var main = 1
  |     ~~~ ^^^^ expected identifier or pattern here
  | 
help: escape the keyword `main` to use it as an identifier:
  | 
4 |     var `main` = 1
  |         ~~~~~~ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
