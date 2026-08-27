// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: %n.old.cj %n.new.cj
// EXEC: %cpfile %n.old.cj lib.cj

// EXEC: %compiler -Woff all %optimization_level_2 %noStackInfo %incrementalCompile %cmp_opt %compile_lib_opt lib.cj -o A.%lib_extension
// EXEC: %compiler -Woff all %optimization_level_2 %noStackInfo %incrementalCompile %cmp_opt %f A.%lib_extension -o %output
// RUN-EXEC-0: %run %run_opt %output %run_args

// EXEC: %cpfile %n.new.cj lib.cj
// EXEC: %compiler -Woff all %optimization_level_2 %noStackInfo %incrementalCompile %cmp_opt %compile_lib_opt lib.cj -o A.%lib_extension > %redirectNull
// EXEC-PIPE-0: %compiler -Woff all %optimization_level_2 %noStackInfo %incrementalCompile %cmp_opt %f A.%lib_extension -o %output 2>&1 && cat .cached/*.log | compare %f
// RUN-EXEC-1: %run %run_opt %output %run_args

internal import inc.*

main() {
    return A<Int64>().f<Int32>()
}
// ASSERT: scan no change
