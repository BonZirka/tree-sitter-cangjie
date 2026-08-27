/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: pkg pkg2
// EXEC: %compiler %cmp_opt %compile_lib_opt pkg/one.cj -o pkg.%middle
// EXEC: %compiler %cmp_opt %compile_lib_opt pkg2/two.cj -o pkg2.%middle
// EXEC: %compiler %cmp_opt %f pkg.%middle pkg2.%middle -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import pkg.*
import pkg2.*

main(){}
