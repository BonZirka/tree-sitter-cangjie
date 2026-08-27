// ERRCHECK: %compiler %f %cmp_opt

main() {
    ####"😌😌😌"
    😌😌😌"####; let a: Int64 = "😌😌"

    """
    😌""";  let b: Int64 = "😌😌"
}

/* SCAN-IN
error: mismatched types
 ==> emoji_in_multistring.cj:5:39:
  | 
5 |     😌😌😌"####; let a: Int64 = "😌😌"
  |                                 ^^^^^^ expected 'Int64', found 'Struct-String'
  | 

error: mismatched types
 ==> emoji_in_multistring.cj:8:30:
  | 
8 |     😌""";  let b: Int64 = "😌😌"
  |                            ^^^^^^ expected 'Int64', found 'Struct-String'
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
