// DEPENDENCE: %n.old.cj %n.new.cj %n.diag.txt
// EXEC: %compiler %incrementalCompile %cmp_opt %n.old.cj -o %output
// EXEC-0: %run %run_opt %output %run_args
// EXEC: %rmfile %n.old.cj
// EXEC: %move %n.new.cj %n.old.cj
// EXEC-PIPE-1: %compiler %incrementalCompile %cmp_opt %n.old.cj -o %output 2>&1 | compare %n.diag.txt
// EXEC: cat .cached/*.log | compare %f
// ASSERT: scan frontend error detected, roll back

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
