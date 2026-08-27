// DEPENDENCE: ../%n.old.cj %n.new.cj
// EXEC: %cpfile %n.old.cj %n.inc.cj
// EXEC: %compiler %incrementalCompile %n.inc.cj -o %output
// EXEC: %run %run_opt %output %run_args
// EXEC: %cpfile %n.new.cj %n.inc.cj
// EXEC-1: %compiler %incrementalCompile %n.inc.cj -o %output 2>&1
// (Linux)EXEC: cat .cached/*.log | compare %n.cj
// ASSERT: scan-not incremental compile result kind
// ASSERT: scan changed decls to recompile: 2
// ASSERT: scan the changed decl after Spreading is:test in file test.inc.cj in line 13 in column 7
// ASSERT: scan the changed decl after Spreading is:foo in file test.inc.cj in line 5 in column 6


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
