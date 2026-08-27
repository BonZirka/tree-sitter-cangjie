// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@Deprecated[what: "sdf"]
func foo() {}

@Deprecated[ok: 222]
func f(): Unit {
}

/* SCAN
error: unknown argument 'what' in @Deprecated
  ==> parse_deprecated_unknown_argument.cj:10:13:
   | 
10 | @Deprecated[what: "sdf"]
   |             ^^^^^^^^^^^ 
   | 

error: unknown argument 'ok' in @Deprecated
  ==> parse_deprecated_unknown_argument.cj:13:13:
   | 
13 | @Deprecated[ok: 222]
   |             ^^^^^^^ 
   | 

2 errors generated, 2 errors printed.
*/
