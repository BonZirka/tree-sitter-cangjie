// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not core dumped
// ASSERT: regex-not Aborted

main() {
    try {
        throw Exception("msg")
    } catch (e: Exception) {
        e.printStackTrace()
        for (i in e.getStackTrace()) {
            println(i.methodName)
        }
    }
}
