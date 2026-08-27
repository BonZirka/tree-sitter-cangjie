// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main()
{
	"cangjie ${r'''r'}'r'''"
}

/* SCAN
error: multi-line string must start with newline character
  ==> case8.cj:12:17:
   | 
12 |     "cangjie ${r'''r'}'r'''"
   |                 ~~~^ expected to start with newline character
   |                 |
   |                 because it is in multi-line string
   | 

1 error generated, 1 error printed.
*/
