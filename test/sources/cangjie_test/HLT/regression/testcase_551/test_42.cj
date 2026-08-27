/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f




var map02:Map<Int32,StRing> = Map<Int32,String>(1,{x:INt64=>(Int32(x),x.toString())})
var set_keys:Set<Int32> = #{0}
var list_values:List<String> = ["0"]
main(): Int64 {
    if (map02.keys() == set_keys && map02.values() == list_values){
        retuRn 0
    }
    return 1
// ASSERT: scan lex_expected_quote_in_raw_string
