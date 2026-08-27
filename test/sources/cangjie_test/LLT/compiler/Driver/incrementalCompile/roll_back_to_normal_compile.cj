// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (CJNATIVE & Linux & DEBUG_OPTION) EXEC: %compiler --experimental --incremental-compile --apc %f -o %output
// (CJNATIVE & Linux & DEBUG_OPTION) EXEC: rm .cached/*.o
// (CJNATIVE & Linux & DEBUG_OPTION) EXEC: %compiler --experimental --incremental-compile --incremental-debug --apc %f -o %output 2>&1 | compare %f
// (CJNATIVE & Linux & DEBUG_OPTION) EXEC: %run_opt %output
// (CJNATIVE & Linux & DEBUG_OPTION) ASSERT: scan cached obj file not exist, roll back to full compilation

func foo() {
    return 0
}

main() {
    foo()
    return 0
}
