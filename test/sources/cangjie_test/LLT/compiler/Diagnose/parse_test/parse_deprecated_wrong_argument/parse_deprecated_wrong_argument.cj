// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@Deprecated["its' message", since: "1990", ok: 222]
class A {
    @Deprecated[since: 322]
    func boo() {}

    @Deprecated[422]
    func goo() {}

    @Deprecated[strict: "true"]
    func doo() {}
}

main(): Unit {}

/* SCAN
error: unknown argument 'ok' in @Deprecated
  ==> parse_deprecated_wrong_argument.cj:10:44:
   | 
10 | @Deprecated["its' message", since: "1990", ok: 222]
   |                                            ^^^^^^^ 
   | 

error: argument 'since' of @Deprecated should be String
  ==> parse_deprecated_wrong_argument.cj:12:24:
   | 
12 |     @Deprecated[since: 322]
   |                        ^^^ 
   | 

error: argument 'message' of @Deprecated should be String
  ==> parse_deprecated_wrong_argument.cj:15:17:
   | 
15 |     @Deprecated[422]
   |                 ^^^ 
   | 

error: argument 'strict' of @Deprecated should be Bool
  ==> parse_deprecated_wrong_argument.cj:18:25:
   | 
18 |     @Deprecated[strict: "true"]
   |                         ^^^^^^ 
   | 

4 errors generated, 4 errors printed.
*/
