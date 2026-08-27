// DEPENDENCE: pkg/pkg.cj pkg/pkg.1.cj pkg/pkg.2.cj
// EXEC: %mkdir pkg
// EXEC: %cpfile pkg.cj pkg/pkg.cj
// EXEC: %compiler %incrementalCompile %cmp_opt %optimization_level_2 -p pkg %compile_lib_opt -o A.%lib_extension
// EXEC: %compiler %incrementalCompile %cmp_opt %optimization_level_2 A.%lib_extension %f -o %output
// EXEC: %run %run_opt %output %run_args
// EXEC: %cpfile pkg.1.cj pkg/pkg.cj
// EXEC: %compiler %cmp_opt %incrementalCompile %optimization_level_2 -p pkg %compile_lib_opt -o A.%lib_extension
// EXEC: %compiler %cmp_opt %optimization_level_2 A.%lib_extension %f -o %output
// EXEC-1: %run %run_opt %output %run_args
// EXEC: %cpfile pkg.2.cj pkg/pkg.cj
// EXEC: %compiler %cmp_opt %incrementalCompile %optimization_level_2 -p pkg %compile_lib_opt -o A.%lib_extension
// EXEC: %compiler %cmp_opt %optimization_level_2 A.%lib_extension %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import pkg.*

func goo1(): Int32 {
    foo1()
    foo2()
}

main(): Int32 {
    goo1()
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
