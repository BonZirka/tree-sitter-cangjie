// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

enum TimeUnit {
    | Year(Int32)
    | Month(Int32, Int32)
}
let oneYear = TimeUnit.Year(1)
main() {
    var howManyHours = match(oneYear){
        case TimeUnit.Year(y | x) => y * 365 * 24
        case _ => 0i32
    }
}

/* SCAN
error: '|' is not allowed here
  ==> ParseEnumPattern.cj:17:30:
   | 
17 |         case TimeUnit.Year(y | x) => y * 365 * 24
   |                              ^ expected ',' or ')', found '|'
   | 

1 error generated, 1 error printed.
*/
