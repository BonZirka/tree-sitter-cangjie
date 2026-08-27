// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE:  define.cj
// EXEC: %compiler %cmp_macro define.cj
// ERRCHECK: %run_macro %compiler %cmp_opt %f -o %output

import define.*

@SAME
@SAME[123]
enum A<T> {
    @SAME
    @SAME[123]
    a
    | @SAME
    @SAME[123]
    a(T)
    | @SAME
    @SAME[123]
    a(T, T)
    | @F[123]
    a(T, T, T)

    @SAME
    @SAME[123]
    public prop x: Int64 {
        get() {
            return 1
        }
    }
}

main() {
    A<Int64>.a(1, 1)
    return 0
}

/* SCAN
error: expected a enum value name after '|' in enum body, found keyword 'func'
  ==> invoke.cj:26:7:
   | 
26 |     | @F[123]
   |     ~ ^^^^ expected a enum value name here
   |     |
   |     after '|' in enum body
   | 
help: you could escape keyword as a enum value name using '`':
   | 
26 |     | `func`23]
   |       ~~~~~~ 
   | 

1 error generated, 1 error printed.
*/
