/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: 01
// EXEC: %compiler %cmp_opt --output liba1.a %pkg_opt 01/src/a1 %compile_lib_opt
// EXEC: %compiler %cmp_opt --output %output %pkg_opt 01/src -L. -la1
// RUN-EXEC: %run %run_opt %output %run_args

