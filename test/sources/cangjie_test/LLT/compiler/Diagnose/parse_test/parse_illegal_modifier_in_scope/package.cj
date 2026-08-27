// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %error_count_limit_all %n.cj 2>&1 | compare %f

public private package a

main () {0}

/* SCAN
error: unexpected modifier 'private' on package declaration
  ==> package.cj:10:8:
   | 
10 | public private package a
   |        ^^^^^^^ ~~~~~~~ on package declaration
   |        |
   |        unexpected modifier
   | 

1 error generated, 1 error printed.
*/
