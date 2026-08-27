// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    @M func a() {} .. @M func b() {}
}

/* SCAN
error: unrecognized operator '..' after declaration
  ==> case7.cj:11:20:
   | 
11 |     @M func a() {} .. @M func b() {}
   |        ~~~~~~~~~~~ ^^ unrecognized operator
   |        |
   |        after declaration
   | 

error: expected expression after '..', found a declaration
  ==> case7.cj:11:26:
   | 
11 |     @M func a() {} .. @M func b() {}
   |                    ~~    ^^^^^^^^^^^ expected expression here
   | 

2 errors generated, 2 errors printed.
*/
