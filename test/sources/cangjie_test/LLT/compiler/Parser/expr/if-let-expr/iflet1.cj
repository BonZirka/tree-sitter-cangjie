// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f




func foo() {
    let a = Some<Int32>(42)
    if (var Some(v) = a) {
        print("Ok")
    }
}

main() {
    0
}


/* SCAN
error: unclosed delimiter: '('
 ==> iflet1.cj:8:9:
  | 
8 |     if (var Some(v) = a) {
  |        ~^ expected ')' here
  |        |
  |        to match this opening '('
  | 

error: expected expression after '(', found keyword 'var'
 ==> iflet1.cj:8:9:
  | 
8 |     if (var Some(v) = a) {
  |         ^^^ expected expression here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
