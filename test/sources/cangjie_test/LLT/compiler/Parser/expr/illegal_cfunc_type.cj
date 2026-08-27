// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

main(): Int32 {
    let cp = CPointer<CFunc<() ->( UInt8>>()
    return -1
}

/* SCAN
error: unclosed delimiter: '('
 ==> illegal_cfunc_type.cj:4:41:
  | 
4 |     let cp = CPointer<CFunc<() ->( UInt8>>()
  |                                  ~      ^ expected ')' here
  |                                  |
  |                                  to match this opening '('
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
