// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

main() {
    let tv = (0, 1)
    let s = match (tv) {
        case (0, 0) => "zero"
        case (var1, `var1`) => "same name" 
    }
}

/* SCAN
error: redefinition of declaration 'var1'
 ==> tuple_pattern_redef.cj:7:22:
  | 
7 |         case (var1, `var1`) => "same name" 
  |                      ^^^^ 
  | 
note: 'var1' is previously declared here
 ==> tuple_pattern_redef.cj:7:15:
  | 
7 |         case (var1, `var1`) => "same name" 
  |               ^^^^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
