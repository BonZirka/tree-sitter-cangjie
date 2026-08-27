// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	var a = r'
	'
}

/* SCAN
error: unterminated rune literal
  ==> case3.cj:12:10:
   | 
12 |     var a = r'
   |             ^^^ unterminated rune literal
   | 

error: unterminated single-line string
  ==> case3.cj:13:2:
   | 
13 |     '
   |     ^^ unterminated single-line string
   | 
   # note: consider using multi-line string if you intended to include '\n' in string

2 errors generated, 2 errors printed.
*/
