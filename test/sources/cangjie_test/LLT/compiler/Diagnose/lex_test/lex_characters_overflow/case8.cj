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
	cangjie ${"cangjie2 ${r'cangjie3'}" r'仓颉'}
"""
}

/* SCAN
error: rune literal may only contain one character
  ==> case8.cj:13:24:
   | 
13 |     cangjie ${"cangjie2 ${r'cangjie3'}" r'仓颉'}
   |                           ^^^^^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
13 |     cangjie ${"cangjie2 ${"cangjie3"}" r'仓颉'}
   |                           ~~~~~~~~~~ 
   | 

error: rune literal may only contain one character
  ==> case8.cj:13:38:
   | 
13 |     cangjie ${"cangjie2 ${r'cangjie3'}" r'仓颉'}
   |                                         ^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
13 |     cangjie ${"cangjie2 ${r'cangjie3'}" "仓颉"}
   |                                         ~~~~~~ 
   | 

2 errors generated, 2 errors printed.
*/
