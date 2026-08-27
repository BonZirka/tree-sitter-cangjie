/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// RUNC-EXEC: %run_macro %run_opt %output %run_utest_opt %run_args
import std.ast.*

@Test
class parse {
    @TestCase
    func testParseType(): Unit {
        let typeNode = parseType(quote(Int64))
        let error = @AssertThrows[ParseASTException](parseType(quote(var x :Int64)))
        @Expect(error.message.contains("parsing type error"))
    }

    @TestCase
    func testParseTypeFragment(): Unit {
        let tokens = quote(Int64(1 + 1))
        let (t, p) = parseTypeFragment(tokens, startFrom: 0)
        let error = @AssertThrows[ParseASTException](parseTypeFragment(quote(var x :Int64), startFrom: 0))
        @Expect(error.message.contains("parsing type fragment error"))
    }

    @TestCase
    func testParseTypeFragment2(): Unit {
        let tokens = quote(Int64(1 + 1))
        let (t, p) = parseTypeFragment(tokens, startFrom: 0)
        @Expect(p,1)
        let error = @AssertThrows[ParseASTException](parseTypeFragment(tokens, startFrom: 1))
        @Expect(error.message.contains("parsing type fragment error"))
        let (t2, p2) = parseTypeFragment(quote(Int64;Int32), startFrom: 0)
        @Expect(p2,1)
        let (t3, p3) = parseTypeFragment(quote(Int64;Int32), startFrom: 2)
        @Expect(p3,3)
    }
    @TestCase
    func testParsePattern(): Unit {
        let pattern = parsePattern(quote(Year(n)))
        let error = @AssertThrows[ParseASTException](parsePattern(quote(case Year(n))))
        @Expect(error.message.contains("parsing pattern error"))
    }

    @TestCase
    func testParsePatternFragment(): Unit {
        let tokens = quote(case Year(n) => 1)
        let (t, p) = parsePatternFragment(tokens, startFrom: 1)
        let error = @AssertThrows[ParseASTException](parsePatternFragment(tokens, startFrom: 0))
        @Expect(error.message.contains("parsing pattern fragment error"))
    }

    @TestCase
    func testParsePatternFragment2(): Unit {
        let tokens = quote(case Year(n) => 1;case Month(n) => 2)
        let (t, p) = parsePatternFragment(tokens, startFrom: 1)
        @Expect(p,5)
        let error = @AssertThrows[ParseASTException](parsePatternFragment(tokens, startFrom: 4))
        @Expect(error.message.contains("parsing pattern fragment error"))
        let (t2, p2) = parsePatternFragment(tokens, startFrom: 9)
    }
}
