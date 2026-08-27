// EXEC-PIPE: %compiler %cmp_opt %f -o %output 2>& 1| compare %f
// EXEC: %run %run_opt %output %run_args

public interface I {
    public open func test1(): Unit
    public func test2(): Unit
    public open prop a : Int64
    public prop b : Int64
}
main() {}

/* SCAN
warning: redundant modifier: 'public'
 ==> public_interface_member.cj:5:5:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     public open func test1(): Unit
  |     ^^^^^^ interface member implies 'public'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'open'
 ==> public_interface_member.cj:5:12:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     public open func test1(): Unit
  |            ^^^^ interface member implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'public'
 ==> public_interface_member.cj:6:5:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     public open func test1(): Unit
6 |     public func test2(): Unit
  |     ^^^^^^ interface member implies 'public'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'public'
 ==> public_interface_member.cj:7:5:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     public open func test1(): Unit
  | ...
7 |     public open prop a : Int64
  |     ^^^^^^ interface member implies 'public'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'open'
 ==> public_interface_member.cj:7:12:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     public open func test1(): Unit
  | ...
7 |     public open prop a : Int64
  |            ^^^^ interface member implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'public'
 ==> public_interface_member.cj:8:5:
  | 
4 | public interface I {
  |        ~~~~~~~~~ 
5 |     public open func test1(): Unit
  | ...
8 |     public prop b : Int64
  |     ^^^^^^ interface member implies 'public'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

6 warnings generated, 6 warnings printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
