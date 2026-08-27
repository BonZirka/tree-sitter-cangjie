// DEPENDENCE: %n.old.cj %n.new.cj
// EXEC: %compiler %enableCompileDebug %incrementalCompile %cmp_opt -Woff unused %n.old.cj -o %output
// EXEC: %run %run_opt %output %run_args
// EXEC: %rmfile %n.old.cj
// EXEC: %move %n.new.cj %n.old.cj
// EXEC-PIPE-0: %compiler %enableCompileDebug %incrementalCompile -Woff unused %cmp_opt %n.old.cj -o %output 2>&1 && cat .cached/*.log | compare %f
// ASSERT: scan changed decls to recompile: 2
// ASSERT: scan the changed decl after Spreading is:a in file Pos.old.cj in line 4 in column 2
// ASSERT: scan the changed decl after Spreading is:b in file Pos.old.cj in line 7 in column 1
// EXEC: %run %run_opt %output %run_args


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
