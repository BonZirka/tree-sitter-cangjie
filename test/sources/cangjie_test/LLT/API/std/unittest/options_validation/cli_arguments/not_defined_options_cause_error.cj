/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %cmp_utest_opt -o %n.%suffix %f
// EXEC-PIPE-1: %run %run_opt %n.%suffix %run_utest_opt %run_args --no-color --not-defined 2>&1 | compare %f
// ASSERT: scan Option 'notDefined' has no validators. Use @UnittestOption macro.

// NOTE: There is no validator for 'notDefined' option passed in CLI
