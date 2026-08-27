/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: A
// EXEC:  %compiler %cmp_opt %compile_lib_opt ./A/A1/a/a.cj -o b.%middle 
// ERRCHECK:  %compiler %cmp_opt %compile_lib_opt b.%middle ./A/A1/A1.cj -o a.%middle
// ASSERT: scan sema_undeclared_identifier

