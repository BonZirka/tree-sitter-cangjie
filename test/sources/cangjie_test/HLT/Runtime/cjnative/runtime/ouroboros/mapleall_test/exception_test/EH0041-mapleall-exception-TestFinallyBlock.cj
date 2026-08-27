/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// (not Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// (Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 1>log.txt && bash -c "dos2unix log.txt" && bash -c "cat log.txt" | compare %f
/* SCAN-IN
13
14
 */

class TestFinallyBlock {
    public var x1: Int32 = 0
    public var x2: Int32 = 0

    public TestFinallyBlock() {
        x1 = -1
        x2 = -1
    }

    public static func TestMain(c: Int32): Int32 {
        var tfb: TestFinallyBlock = TestFinallyBlock()
        try {
            var data: Int32 = 25 / 5
        } catch (e: Exception) {
            tfb.x1 = 2
        } finally {
            tfb.x2 = 3
        }
        tfb.x1 += 11
        var res: Int32 = tfb.x1 + tfb.x2
        return res + c
    }
}

main(): Int64 {
    print(TestFinallyBlock.TestMain(0).toString() + "\n")
    print(TestFinallyBlock.TestMain(1).toString() + "\n")
    return 0
}
