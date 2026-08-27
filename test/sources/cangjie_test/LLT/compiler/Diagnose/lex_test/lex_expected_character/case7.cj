// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	"cangjie ${r''}"
}

/* SCAN
error: expected one character in rune literal
  ==> case7.cj:12:13:
   | 
12 |     "cangjie ${r''}"
   |                ^^^ expected one character in rune literal
   | 

1 error generated, 1 error printed.
*/
