// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

class A {
    var a: Int32 = 42
    public mut prop b {  
        get() {
            return a
        }
        set(value) {
            this.a = value
        }
    }
}

main() {
    0
}


/* SCAN
error: expected ':', found '{'
 ==> class_prop_var.cj:5:23:
  | 
5 |     public mut prop b {  
  |                       ^ expected ':' here
  | 
  # note: property declaration must declare type explicitly

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
