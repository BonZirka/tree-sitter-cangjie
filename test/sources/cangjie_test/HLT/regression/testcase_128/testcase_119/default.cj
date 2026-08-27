/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: mod1
// EXEC: %compiler %cmp_opt %compile_lib_opt ./mod1/src/p1/*.cj --module-name mod1 -o mod1/a.%middle
// ERRCHECK: %compiler %cmp_opt  %f -o %output



import mod1.p1.a

main(): Int64 {
    if ( a != 1 ){
        return 1
    }
    if ( p1.a != 1 ){
        return 1
    }
    if ( mod1>p1.a != 1 ){
        return 1
    }
// ASSERT: scan parse_expected_right_delimiter
