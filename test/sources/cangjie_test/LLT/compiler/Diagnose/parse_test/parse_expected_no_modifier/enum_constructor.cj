// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum E {
	| private a (Int32) | public b 
}
main () {
	0
}

/* SCAN
error: expected no modifier before enum constructor, found 'private'
  ==> enum_constructor.cj:11:4:
   | 
11 |     | private a (Int32) | public b 
   |       ^^^^^^^ ~ before enum constructor
   |       |
   |       expected no modifier here
   | 

error: expected no modifier before enum constructor, found 'public'
  ==> enum_constructor.cj:11:24:
   | 
11 |     | private a (Int32) | public b 
   |                           ^^^^^^ ~ before enum constructor
   |                           |
   |                           expected no modifier here
   | 

2 errors generated, 2 errors printed.
*/
