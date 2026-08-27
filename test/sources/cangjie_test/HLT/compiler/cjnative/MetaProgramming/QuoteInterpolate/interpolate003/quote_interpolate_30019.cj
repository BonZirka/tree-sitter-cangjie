/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// ERRCHECK: %compiler %cmp_opt %use_ast %f -o %output



import std.ast.*

func test(){
    var x = quote($&&)
    x.dump()
}

main(){
    test()
    return 0
}
// ASSERT: scan parse_expect_escape_dollar_token
