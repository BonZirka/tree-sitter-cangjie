/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run %run_opt %output %run_utest_opt %run_args 

import std.math.*

@Test
class Test_option_1 {
    @TestCase
    func test_option_flatten_01(): Unit {
        let opt1 = Option<Int32>.None
        let optInt: Option<Int64> = Some(100)
        let optstr: Option<String> = Some("Hello")
        let opt2 = Some(Int32.Min)
        let opt3 = Some(Int32.Max)
        let opt4 = Some(opt1)
        let opt5 = Some(opt2)
        let opt6 = Some(opt3)
        try {
            opt4.flatten().getOrThrow().toString()
        } catch (e: NoneValueException) {
            @Expect(e.toString(),"NoneValueException")
        }
        @Expect(optInt.isNone(),false)
        @Expect(optstr.isSome(),true)
    }
}
