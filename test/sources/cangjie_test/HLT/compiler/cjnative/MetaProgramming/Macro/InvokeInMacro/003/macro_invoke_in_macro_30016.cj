/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: define_a_30016.cj define_b_30016.cj  define_c_30016.cj define_d_30016.cj define_e_30016.cj
// EXEC: %compiler define_a_30016.cj %cmp_macro
// EXEC: %compiler define_b_30016.cj %cmp_macro
// EXEC: %compiler define_c_30016.cj %cmp_macro
// EXEC: %compiler define_d_30016.cj %cmp_macro
// EXEC: %compiler define_e_30016.cj %cmp_macro
// EXEC: %compiler %cmp_opt %f -o %output

// RUN-EXEC: %run %run_opt %output %run_args

package use

import E.*

main() {
    return @e1[1](2) + @e2[1](2)
}
