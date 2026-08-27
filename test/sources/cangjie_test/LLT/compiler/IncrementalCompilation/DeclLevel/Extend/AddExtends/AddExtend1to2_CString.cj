// DEPENDENCE: %n.old.cj %n.new.cj
// EXEC: %compiler %incrementalCompile %n.old.cj -o %output
// EXEC: %cpfile %n.new.cj %n.old.cj
// EXEC-PIPE: %compiler %incrementalCompile %n.old.cj -o %output 2>&1 && cat .cached/*.log | compare %f
// RUN-EXEC-2: %run %run_opt %output %run_args
// ASSERT: scan changed decls to recompile: 2
// ASSERT: scan the changed decl after Spreading is:main in file AddExtend1to2_CString.old.cj in line 5 in column 1
// ASSERT: scan the changed decl after Spreading is:foo in file AddExtend1to2_CString.old.cj in line 15 in column 10


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
