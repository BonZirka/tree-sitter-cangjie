// ERRCHECK: %compiler %f %cmp_opt

main() {
    /*😌😌😌😌 */; let 幻象: Int64 = "😌"// 😌😌 
}

/* SCAN-IN
error: mismatched types
 ==> emoji_in_comment.cj:4:48:
  | 
4 |     /*😌😌😌😌 */; let 幻象: Int64 = "😌"// 😌😌 
  |                                      ^^^^ expected 'Int64', found 'Struct-String'
  | 

1 error generated, 1 error printed.
*/
// the position may not look right in some code editors, but is correct on terminals

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
