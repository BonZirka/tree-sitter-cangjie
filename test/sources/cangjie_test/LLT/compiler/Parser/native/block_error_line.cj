// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

public foreign var a = 1 
public foreign let b = 1 

foreign {
    public var c = 1 
    public let d = 1 
}

/* SCAN
error: 'foreign' and 'public' modifiers conflict on variable declaration
 ==> block_error_line.cj:3:8:
  | 
3 | public foreign var a = 1 
  | ~~~~~~ ^^^^^^^ ~~~ on variable declaration
  | |      |
  | |      unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'foreign' and 'public' modifiers conflict on variable declaration
 ==> block_error_line.cj:4:8:
  | 
4 | public foreign let b = 1 
  | ~~~~~~ ^^^^^^^ ~~~ on variable declaration
  | |      |
  | |      unexpected modifier
  | |
  | because it is conflicted with this
  | 

error: 'public' and 'foreign' modifiers conflict on variable declaration
 ==> block_error_line.cj:7:5:
  | 
6 | foreign {
  | ~~~~~~~ because it is conflicted with this
7 |     public var c = 1 
  |     ^^^^^^ ~~~ on variable declaration
  |     |
  |     unexpected modifier
  | 

error: 'public' and 'foreign' modifiers conflict on variable declaration
 ==> block_error_line.cj:8:5:
  | 
6 | foreign {
  | ~~~~~~~ because it is conflicted with this
7 |     public var c = 1 
8 |     public let d = 1 
  |     ^^^^^^ ~~~ on variable declaration
  |     |
  |     unexpected modifier
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
