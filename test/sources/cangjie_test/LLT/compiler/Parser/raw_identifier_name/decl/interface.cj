// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

interface `I` {
    func f(): Unit
}
interface I {
    func f(): Unit
}

main() {
    0
}

/* SCAN
error: redefinition of declaration 'I'
 ==> interface.cj:6:11:
  | 
6 | interface I {
  |           ^ 
  | 
note: 'I' is previously declared here
 ==> interface.cj:3:12:
  | 
3 | interface `I` {
  |            ^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
