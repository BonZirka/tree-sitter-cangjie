// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

main(): Int64 {
    return match (2) {
        case 1 | 2 => 0
        case _ => 4
    }
}

/* SCAN
warning: unreachable pattern
  ==> ParsePatternInCase.cj:13:14:
   | 
13 |         case _ => 4
   |              ^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

1 warning generated, 1 warning printed.
*/
