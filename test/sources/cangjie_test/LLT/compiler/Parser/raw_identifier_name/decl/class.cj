// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

class A {
    var var1 = 10;
}

class `A` {
    var var1 = 10;
}

main() {
    0
}

/* SCAN
error: redefinition of declaration 'A'
 ==> class.cj:7:8:
  | 
7 | class `A` {
  |        ^ 
  | 
note: 'A' is previously declared here
 ==> class.cj:3:7:
  | 
3 | class A {
  |       ^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
