// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class C where {
}

main () {}

/* SCAN
error: unexpected 'where' in non-generic declaration
  ==> class.cj:10:9:
   | 
10 | class C where {
   |       ~ ^^^^^ unexpected 'where' here
   |       |
   |       because this declaration is non-generic
   | 

1 error generated, 1 error printed.
*/
