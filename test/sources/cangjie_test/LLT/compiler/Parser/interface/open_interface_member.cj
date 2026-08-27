// EXEC-PIPE: %compiler %cmp_opt %f -o %output 2>& 1| compare %f
// EXEC: %run %run_opt %output %run_args

public interface I {
    open func test(): Unit
    open prop a : Int64
}
main() {}

/* SCAN
warning: redundant modifier: 'open'
 ==> open_interface_member.cj:5:5:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     open func test(): Unit
  |     ^^^^ interface member implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'open'
 ==> open_interface_member.cj:6:5:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     open func test(): Unit
6 |     open prop a : Int64
  |     ^^^^ interface member implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

2 warnings generated, 2 warnings printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
