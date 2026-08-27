/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color --show-all-output --capture-output | compare %f
// ASSERT: scan-1 Also print!
// ASSERT: scan-1 Printing to stdout
// ASSERT: scan-1 Printing to stderr

@Test
func passingAndPrinting() {
    println("Also print!")
}

@Test
func failingAndPrinting() {
    println("Printing to stdout")
    eprintln("Printing to stderr")
    @Expect(1, 2)
}
