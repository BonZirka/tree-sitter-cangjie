// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

extend foo {
    main() {}
}

/* SCAN
error: unexpected main function in extend body
  ==> case66.cj:11:5:
   | 
10 | extend foo {
   | ~~~~~~ in extend
11 |     main() {}
   |     ^^^^ unexpected main function
   | 

1 error generated, 1 error printed.
*/
