/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: mytest/multi_str_macro.cj
// EXEC: %compiler %cmp_macro multi_str_macro.cj
// ERRCHECK: %run_macro %compiler %cmp_opt %f %macro_debug -o %output 

import mytest.MSTR

@MSTR(
import stdx.net.http.*
main(){
    return 0
}
)
// ASSERT: scan parse_expected_decl
