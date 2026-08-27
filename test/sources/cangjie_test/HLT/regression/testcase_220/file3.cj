/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: p1
// DEPENDENCE: p2
// EXEC:%compiler %cmp_opt  p1/file1.cj %compile_lib_opt -o file1.%middle
// EXEC:%compiler %cmp_opt  p2/file2.cj %compile_lib_opt -o file2.%middle
// EXEC:%compiler %cmp_opt file1.%middle file2.%middle file3.cj -o %output
// RUN-EXEC: %run %run_opt %output %run_args
 
import test1.*
import test2.*
 
main() {
    f1<Int64>()
    f2<Int64>()
    0
}
