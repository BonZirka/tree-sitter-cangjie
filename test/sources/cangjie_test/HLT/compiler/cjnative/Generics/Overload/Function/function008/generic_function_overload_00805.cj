/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: a.cj c.cj  c.cfg
// EXEC: %compiler %cmp_opt %compile_lib_opt a.cj -o a.%middle
// EXEC: %compiler %cmp_opt %compile_lib_opt c.cj -o c.%middle
// ERRCHECK: %compiler %cmp_opt  a.%middle c.%middle %f -o %output

package pkg801

import a.*
import c.*

main(): Int64 {
    var I = test(1)
    return 0
}
// ASSERT: scan sema_ambiguous_match
