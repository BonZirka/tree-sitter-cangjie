// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

class dfqof {
  dfqof(public protected let a: Int64) {}
}

main() {
}

/* SCAN
error: 'protected' and 'public' modifiers conflict on variable declaration
  ==> case30.cj:11:16:
   | 
11 |   dfqof(public protected let a: Int64) {}
   |         ~~~~~~ ^^^^^^^^^ ~~~ on variable declaration
   |         |      |
   |         |      unexpected modifier
   |         |
   |         because it is conflicted with this
   | 

1 error generated, 1 error printed.
*/
