/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ../helpers
// EXEC: %compiler %cmp_opt -p helpers --mock=on %compile_lib_opt --output p1.%middle
// EXEC: %compiler %cmp_opt p1.%middle %n.cj -o %output %cmp_utest_opt 2>&1
// EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1

import std.mock_test_util.*

class A {}

class B {}

let a = unsafe { createMock<A>(dummyMockingCallHandler) }
let a1 = unsafe { createMock<A>(dummyMockingCallHandler) }
let b = unsafe { createMock<B>(dummyMockingCallHandler) }

main() {
    0
}
