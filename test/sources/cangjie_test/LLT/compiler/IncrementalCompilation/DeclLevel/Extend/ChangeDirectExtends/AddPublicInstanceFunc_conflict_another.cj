// DEPENDENCE: %n.old.cj %n.new.cj %n.diag.txt
// EXEC: %compiler %incrementalCompile %n.old.cj -o %output
// EXEC: %cpfile %n.new.cj %n.old.cj
// EXEC-PIPE-1: %compiler %incrementalCompile %n.old.cj -o %output 2>&1 %cmp_opt | compare %n.diag.txt
// EXEC: cat .cached/*.log | compare %f
// ASSERT: scan changed decls to recompile: 5
// ASSERT: scan the changed decl after Spreading is:A in file AddPublicInstanceFunc_conflict_another.old.cj in line 1 in column 7
// ASSERT: scan the changed decl after Spreading is:ExtendDecl in file AddPublicInstanceFunc_conflict_another.old.cj in line 3 in column 1
// ASSERT: scan the changed decl after Spreading is:ExtendDecl in file AddPublicInstanceFunc_conflict_another.old.cj in line 8 in column 1
// ASSERT: scan the changed decl after Spreading is:foo in file AddPublicInstanceFunc_conflict_another.old.cj in line 9 in column 17
// ASSERT: scan the changed decl after Spreading is:main in file AddPublicInstanceFunc_conflict_another.old.cj in line 12 in column 1

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
