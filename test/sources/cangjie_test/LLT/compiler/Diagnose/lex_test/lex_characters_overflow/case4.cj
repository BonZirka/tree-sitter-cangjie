// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	"cangjie ${r'cangjie1'}" r'cangjie2'
}

/* SCAN
error: rune literal may only contain one character
  ==> case4.cj:12:13:
   | 
12 |     "cangjie ${r'cangjie1'}" r'cangjie2'
   |                ^^^^^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
12 |     "cangjie ${"cangjie1"}" r'cangjie2'
   |                ~~~~~~~~~~ 
   | 

error: rune literal may only contain one character
  ==> case4.cj:12:27:
   | 
12 |     "cangjie ${r'cangjie1'}" r'cangjie2'
   |                              ^^^^^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
12 |     "cangjie ${r'cangjie1'}" "cangjie2"
   |                              ~~~~~~~~~~ 
   | 

2 errors generated, 2 errors printed.
*/
