// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	var a = r''
}

/* SCAN
error: expected one character in rune literal
  ==> case1.cj:12:10:
   | 
12 |     var a = r''
   |             ^^^ expected one character in rune literal
   | 

1 error generated, 1 error printed.
*/
