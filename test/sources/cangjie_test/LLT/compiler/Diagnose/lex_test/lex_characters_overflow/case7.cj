// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


main()
{
	r'仓颉'
}

/* SCAN
error: rune literal may only contain one character
  ==> case7.cj:13:2:
   | 
13 |     r'仓颉'
   |     ^^^^^^^ may only contain one character
   | 
help: if you intended to write a string literal, use '"':
   | 
13 |     "仓颉"
   |     ~~~~~~ 
   | 

1 error generated, 1 error printed.
*/
