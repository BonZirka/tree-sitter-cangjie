// DEPENDENCE: %n.old.cj %n.new.cj
// EXEC: %mkdir out
// EXEC: %cpfile %n.old.cj lib.cj
// EXEC: %cpfile %f main.cj

// EXEC: %compiler -Woff all %noStackInfo %incrementalCompile %cmp_opt %compile_lib_opt lib.cj -o A.%lib_extension
// EXEC: %compiler -Woff all %noStackInfo %incrementalCompile %cmp_opt main.cj A.%lib_extension -o out/%output
// RUN-EXEC: %run %run_opt out/%output %run_args

// EXEC: %cpfile %n.new.cj lib.cj

// EXEC: %compiler -Woff all %noStackInfo %incrementalCompile %cmp_opt %compile_lib_opt lib.cj -o A.%lib_extension > %redirectNull
// EXEC-PIPE-0: %compiler -Woff all %noStackInfo %incrementalCompile %cmp_opt main.cj A.%lib_extension -o out/%output 2>&1 && cat out/.cached/*.log | compare %f
// RUN-EXEC: %run %run_opt out/%output %run_args

internal import inc.*

main(): Int64 {
    return A().foo()
}

// ASSERT: scan begin dump raw modified decls:
// ASSERT: scan 1A<:X lib.cj 4: body 
// ASSERT: scan     added members 1: 3inc7Extend!1A<:X3barF$$Int64 
// ASSERT: scan incremental compilation triggered
// ASSERT: scan begin dump incremental compile result:
// ASSERT: scan changed decls to recompile: 2
// ASSERT: scan the changed decl after Spreading is:A in file lib.cj in line 3 in column 14
// ASSERT: scan the changed decl after Spreading is:ExtendDecl in file lib.cj in line 4 in column 1
// ASSERT: scan incremental sema


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
