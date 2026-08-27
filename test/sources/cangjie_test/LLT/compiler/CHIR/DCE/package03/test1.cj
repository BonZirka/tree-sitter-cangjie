// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (CJNATIVE) DEPENDENCE: p1
// (CJNATIVE and DEBUG_OPTION) EXEC:%compiler  %debugCHIROpt  %disableReflection %enableO2 p1/test0.cj %compile_lib_opt -o test0.%middle
// (CJNATIVE and DEBUG_OPTION) EXEC:%compiler  %debugCHIROpt  %disableReflection %enableO2 test0.%middle test1.cj -o %output 2>&1 | compare %f
// (CJNATIVE and DEBUG_OPTION) EXEC: %run %output

internal import test0.*

main() {
    let a = B<Int64>()
    let b = B<Int32>()
    return 0
}

// (CJNATIVE) ASSERT: scan-not will be deleted
// (CJNATIVE) ASSERT: scan-not core dumped
// (CJNATIVE) ASSERT: scan-not stack trace