// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	"""
	cangjie1 ${r''} ${"cangjie2 ${r''}"} ''
"""
}

/* SCAN
error: expected one character in rune literal
  ==> case9.cj:13:13:
   | 
13 |     cangjie1 ${r''} ${"cangjie2 ${r''}"} ''
   |                ^^^ expected one character in rune literal
   | 

error: expected one character in rune literal
  ==> case9.cj:13:32:
   | 
13 |     cangjie1 ${r''} ${"cangjie2 ${r''}"} ''
   |                                   ^^^ expected one character in rune literal
   | 

2 errors generated, 2 errors printed.
*/
