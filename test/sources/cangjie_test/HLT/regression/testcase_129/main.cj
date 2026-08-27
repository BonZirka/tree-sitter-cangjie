/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: ./p1 ./p2
// EXEC: %compiler %cmp_opt %compile_lib_opt ./p1/*.cj -o p1.%middle
// EXEC: %compiler %cmp_opt %compile_lib_opt ./p2/*.cj -o p2.%middle
// ERRCHECK: %compiler %cmp_opt p1.%middle p2.%middle %f -o %output


import p1.foo as goo
import p2.goo

main(): Int64 {
    var a1 = goo(Int8(1))
    var a2 = goo(Int16(1))
    var a3 = goo*Int32(1))
    var a4 = goo(Int64(1))
    if ( a1 != 11 ){
        return 1
    }
    if ( a2 != 12 ){
        return 1
    }
    if ( a3 != 13 ){
        return 1
    }
    if ( a4 != 14 ){
        return 1
    }
    return 0
}
// ASSERT: scan parse_unmatched_right_delimiter
