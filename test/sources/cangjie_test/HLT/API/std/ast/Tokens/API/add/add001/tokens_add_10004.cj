/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC: %run %run_opt %output  %run_args

import std.ast.*

var id = getTokenKind(3)

func check(a:Token, b: Token):Int64 {

    if (a == b) {
        return 0
    }
    return 3
}

main(){
    var T1 : Tokens = Tokens([Token(id).addPosition(1,2,3)])
    var t1 = Token()
    var res1 = T1 + t1
    var res2 = t1 + T1
    if (res1.size != 2 || res2.size != 2) {
        return 1
    }
    return check(res1.get(0),res2.get(1))
}
