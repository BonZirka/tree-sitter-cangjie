/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE:  definea.cj defineb.cj definec.cj defined.cj
// EXEC: %compiler definea.cj %cmp_macro
// EXEC: %compiler defineb.cj %cmp_macro
// EXEC: %compiler definec.cj %cmp_macro
// EXEC: %compiler defined.cj %cmp_macro
// ERRCHECK: %compiler %cmp_opt  %f -o %output

import definea.A
import defineb.B
import definec.X
import defined.D

main() {
    3 - @X[0](@B@D[0]@A(0))
}
// ASSERT: scan parse_expected_decl
