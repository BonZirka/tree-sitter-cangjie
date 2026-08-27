// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	"cangjie ${r'cangjie 1'}"
}

/* SCAN
error: rune literal may only contain one character
  ==> case2.cj:12:13:
   | 
12 |     "cangjie ${r'cangjie 1'}"
   |                ^^^^^^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
12 |     "cangjie ${"cangjie 1"}"
   |                ~~~~~~~~~~~ 
   | 

1 error generated, 1 error printed.
*/
