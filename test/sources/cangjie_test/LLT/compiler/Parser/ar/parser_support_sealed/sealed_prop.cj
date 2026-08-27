// ERRCHECK: %compiler %cmp_opt %f -o %output

sealed class C {
    sealed mut prop p: Int64 {
        get() { 0 }
        set(v) {}
    }
}
main() {}

/* SCAN
error: unexpected modifier 'sealed' on property declaration in class body
 ==> sealed_prop.cj:4:5:
  | 
3 | sealed class C {
  |        ~~~~~ in class
4 |     sealed mut prop p: Int64 {
  |     ^^^^^^     ~~~~ on property declaration
  |     |
  |     unexpected modifier
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
