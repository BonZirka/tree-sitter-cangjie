// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
    mut prop a : Int64 {
        get() {
            public main() {}
            0
        }
    }
}

/* SCAN
error: unexpected main function in getter body
  ==> case72.cj:13:20:
   | 
12 |         get() {
   |         ~~~ in getter
13 |             public main() {}
   |                    ^^^^ unexpected main function
   | 

1 error generated, 1 error printed.
*/
