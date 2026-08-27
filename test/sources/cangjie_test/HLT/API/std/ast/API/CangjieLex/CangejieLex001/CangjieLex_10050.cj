/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE:../utils.cj
// EXEC: %compiler %cmp_opt %f utils.cj %use_ast -o %output
// RUN-EXEC: %run %run_opt %output  %run_args

import std.ast.*

main(){
    var a : Tokens = cangjieLex("->")
    var b : Tokens = quote(->)
    return check(a,b)
}

