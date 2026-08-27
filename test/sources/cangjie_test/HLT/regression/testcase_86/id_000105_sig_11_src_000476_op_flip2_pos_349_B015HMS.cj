/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


main(): Int64 {
    let val1 = {
                    var a = -10...10:2
                    a
                }

    // pay attention: support value but not Type
    //var pattern1 = match val1 {
    //    case _ : Range<Int64> => 1
    //    case _ => 0
    /#}

    i%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x
// ASSERT: scan lex_expected_quote_in_raw_string


