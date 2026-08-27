// ERRCHECK: %compiler %cmp_opt %f -o %output

func g(a: ()->Unit) {}


main() {
    if (true) {
        g
    } else {
        g
    }(){}
}

/* SCAN
error: trailing closure can only be used on function calls with function or variable names
  ==> if_expr.cj:7:5:
   | 
7  |       if (true) {
   |  _____^
8  | |         g
   | | ...
11 | |     }(){}
   | |_______^
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
