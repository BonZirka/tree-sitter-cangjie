// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

inout
class AAA{}
main() {}

/* SCAN
error: unexpected modifier 'inout' on class declaration
 ==> inout.cj:3:1:
  | 
3 | inout
  | ^^^^^ unexpected modifier
4 | class AAA{}
  | ~~~~~ on class declaration
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
