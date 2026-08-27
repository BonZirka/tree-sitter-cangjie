// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// ERRCHECK: %compiler %f %cmp_opt

@C
@C
func foo() {}

@JavaMirror
@JavaMirror
class Foo {}

@OverflowWrapping
@OverflowWrapping
func bar() {}

/* SCAN
error: duplicated annotation: '@C'
  ==> duplicate_builtin.cj:10:1:
   | 
9  | @C
   | ~~ the previous one is here
10 | @C
   | ^^ duplicated annotation here
   | 

error: duplicated annotation: '@JavaMirror'
  ==> duplicate_builtin.cj:14:1:
   | 
13 | @JavaMirror
   | ~~~~~~~~~~~ the previous one is here
14 | @JavaMirror
   | ^^^^^^^^^^^ duplicated annotation here
   | 

error: duplicated annotation: '@OverflowWrapping'
  ==> duplicate_builtin.cj:18:1:
   | 
17 | @OverflowWrapping
   | ~~~~~~~~~~~~~~~~~ the previous one is here
18 | @OverflowWrapping
   | ^^^^^^^^^^^^^^^^^ duplicated annotation here
   | 

3 errors generated, 3 errors printed.
*/
