// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>& 1| compare %f

public interface I {
    open static func test(): Unit
    static open prop a : Int64
}
main() {}

/* SCAN
error: 'static' and 'open' modifiers conflict on function declaration
 ==> open_static_interface_member.cj:4:10:
  | 
4 |     open static func test(): Unit
  |     ~~~~ ^^^^^^ ~~~~ on function declaration
  |     |    |
  |     |    unexpected modifier
  |     |
  |     because it is conflicted with this
  | 

error: 'open' and 'static' modifiers conflict on property declaration
 ==> open_static_interface_member.cj:5:12:
  | 
5 |     static open prop a : Int64
  |     ~~~~~~ ^^^^ ~~~~ on property declaration
  |     |      |
  |     |      unexpected modifier
  |     |
  |     because it is conflicted with this
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
