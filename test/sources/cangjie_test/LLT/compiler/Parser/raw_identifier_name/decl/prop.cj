// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

class Foo {
    var a = 0
    prop b : Int64{
        get() {a}
    }
    prop `b` : Int64{
        get() {a}
    }
}
main() {
    0
}

/* SCAN
error: redefinition of declaration 'b'
 ==> prop.cj:8:11:
  | 
8 |     prop `b` : Int64{
  |           ^ 
  | 
note: 'b' is previously declared here
 ==> prop.cj:5:10:
  | 
5 |     prop b : Int64{
  |          ^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
