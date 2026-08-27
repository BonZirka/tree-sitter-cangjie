// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// ERRCHECK: %run_macro %compiler %cmp_opt %f -o %output

import std.ast.*
import cangjie_try.*

@Callback
public func t() {
}

main() {
}

/* SCAN
error: the error originates in the macro `Callback` (consider using `--debug-macro` for more info)
  ==> main.cj:15:1:
   | 
15 |   @Callback
   |  _^
16 | | public func t() {
17 | | }
   | |_^
   | 
note: expected 'catch' or 'finally' after try block, found '<EOF>'
   | 
   |       let a = try {
   |  _____________~
   | |         1
   | |     }
   | |     ~^ expected 'catch' or 'finally' here
   | |_____|
   |       
   | 

error: the error originates in the macro `Callback` (consider using `--debug-macro` for more info)
  ==> main.cj:15:1:
   | 
15 |   @Callback
   |  _^
16 | | public func t() {
17 | | }
   | |_^
   | 
note: unclosed delimiter: '{'
   | 
   | func u(): Unit {
   |                ~ to match this opening '{'
   |     let a = try {
   |         1
   |     }
   |      ^ expected '}' here
   | 

2 errors generated, 2 errors printed.
*/
