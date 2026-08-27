/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: A/a.cj B/b.cj 
// EXEC: %compiler %cmp_opt %compile_lib_opt a.cj -o a.%middle
// EXEC: %compiler %cmp_opt %compile_lib_opt b.cj -o b.%middle
// EXEC: %compiler %cmp_opt %f a.%middle b.%middle -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import A.*
import B.*
main() {
   BB().test<Int64>()
  0
}
