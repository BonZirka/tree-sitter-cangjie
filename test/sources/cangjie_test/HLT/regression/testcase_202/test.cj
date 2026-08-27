/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: pkg.cj
// EXEC: %compiler %cmp_opt %compile_lib_opt pkg.cj -o pkg.%middle
// EXEC: %compiler %cmp_opt pkg.%middle %f -o %output
// RUN-EXEC: %run %run_opt %output

import pkg.*

// Test for static member of same type of instantiated class only exist once
main(){
    if (A<Int64>.a != 1) {
        return 1
    }
    test()
    if (A<Int64>.a != 3) {
        return 2
    }
    return 0
}


