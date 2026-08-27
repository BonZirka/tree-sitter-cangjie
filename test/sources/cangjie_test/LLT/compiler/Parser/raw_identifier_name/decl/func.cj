// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f
 
func test() {}
func `test`() {}

 
main() {
    0
}
 
/* SCAN
error: function 'test' has overload conflicts
 ==> func.cj:4:7:
  | 
4 | func `test`() {}
  |       ^^^^ 
  | 
note: conflict with the declaration
 ==> func.cj:3:6:
  | 
3 | func test() {}
  |      ^^^^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
