// DEPENDENCE: ../template.cj %n.new.cj
// EXEC: %cpfile template.cj main.cj
// EXEC: %compiler -Woff all %noStackInfo %incrementalCompile %cmp_opt main.cj -o %output
// RUN-EXEC: %run %run_opt %output %run_args

// EXEC: %cpfile %n.new.cj main.cj
// EXEC-PIPE-0: %compiler -Woff all %noStackInfo %incrementalCompile %cmp_opt main.cj -o %output 2>&1 && cat .cached/*.log | compare %f
// RUN-EXEC: %run %run_opt %output %run_args

// ASSERT: scan begin dump raw modified decls:
// ASSERT: scan S 7default1SS main.cj 1:
// ASSERT: scan changed members 1:
// ASSERT: scan 7default1SS1aV$$l: srcuse
// ASSERT: scan incremental compilation triggered
// ASSERT: scan begin dump incremental compile result:
// ASSERT: scan changed decls to recompile: 1
// ASSERT: scan the changed decl after Spreading is:a in file main.cj in line 5 in column 5
// ASSERT: scan incremental sema



// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
