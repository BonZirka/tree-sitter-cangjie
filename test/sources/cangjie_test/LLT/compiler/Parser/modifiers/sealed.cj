// EXEC-PIPE-1: %compiler %f %compile_lib_opt %cmp_opt 2>&1 | compare %f

private sealed class A {}
sealed private class B {}

protected sealed interface I1 {}
sealed protected interface I4 {}
sealed internal interface I2<T> {}
internal sealed class I3 {}

/*SCAN-IN
error: 'sealed' and 'private' modifiers conflict on class declaration
 ==> sealed.cj:3:9:
  | 
3 | private sealed class A {}
  | ~~~~~~~ ^^^^^^ ~~~~~ on class declaration
  | |       |
  | |       unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'private' and 'sealed' modifiers conflict on class declaration
 ==> sealed.cj:4:8:
  | 
4 | sealed private class B {}
  | ~~~~~~ ^^^^^^^ ~~~~~ on class declaration
  | |      |
  | |      unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'sealed' and 'protected' modifiers conflict on interface declaration
 ==> sealed.cj:6:11:
  | 
6 | protected sealed interface I1 {}
  | ~~~~~~~~~ ^^^^^^ ~~~~~~~~~ on interface declaration
  | |         |
  | |         unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'protected' and 'sealed' modifiers conflict on interface declaration
 ==> sealed.cj:7:8:
  | 
7 | sealed protected interface I4 {}
  | ~~~~~~ ^^^^^^^^^ ~~~~~~~~~ on interface declaration
  | |      |
  | |      unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'internal' and 'sealed' modifiers conflict on interface declaration
 ==> sealed.cj:8:8:
  | 
8 | sealed internal interface I2<T> {}
  | ~~~~~~ ^^^^^^^^ ~~~~~~~~~ on interface declaration
  | |      |
  | |      unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'sealed' and 'internal' modifiers conflict on class declaration
 ==> sealed.cj:9:10:
  | 
9 | internal sealed class I3 {}
  | ~~~~~~~~ ^^^^^^ ~~~~~ on class declaration
  | |        |
  | |        unexpected modifier
  | |
  | because it is conflicted with this
  | 

6 errors generated, 6 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
