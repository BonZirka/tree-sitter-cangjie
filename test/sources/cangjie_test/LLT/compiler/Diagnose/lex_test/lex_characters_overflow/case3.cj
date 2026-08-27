// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	r'cangjie1'
	r'cangjie2'
}

/* SCAN
error: rune literal may only contain one character
  ==> case3.cj:12:2:
   | 
12 |     r'cangjie1'
   |     ^^^^^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
12 |     "cangjie1"
   |     ~~~~~~~~~~ 
   | 

error: rune literal may only contain one character
  ==> case3.cj:13:2:
   | 
13 |     r'cangjie2'
   |     ^^^^^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
13 |     "cangjie2"
   |     ~~~~~~~~~~ 
   | 

2 errors generated, 2 errors printed.
*/
