/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./xmlparser
// EXEC: %compiler %cmp_opt -p xmlparser %compile_lib_opt --output p1.%middle
// EXEC: %compiler %cmp_opt p1.%middle %f -o %output %cmp_utest_opt
// EXEC-1: %run %run_opt %output %run_args --no-color --reportFormat=xml-per-package --reportPath=tmp --filter=-Suite1 --death-aware
// EXEC: %compiler %cmp_opt p1.%middle %f -o %output
// EXEC: %run %run_opt %output %run_utest_opt %run_args --no-color

package a.b.c

import xmlparser.*
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.time.*
import std.collection.*
import std.env.*

@Test
class Suite1 {
    @TestCase
    func case1() {}
}

@Test 
class Suite2 {
    @TestCase
    func case1() {
    }

    @TestCase
    func case2() {
        exit(10)
    }
}

@Test
@Types[T in <Int64, Float64>]
class Suite3<T> {
    @TestCase
    func case1() {}
}

func assert(passed: Bool, msg: String) {
    if (!passed) {
        throw Exception(msg)
    }
}

main() {
    let packname = "a.b.c"
    let dir = canonicalize(Path(".")).join("tmp").join("tests")
    let reportPath = dir.join("test-${packname}.xml")
    if (!exists(reportPath)) { throw Exception("Report file must exist") }

    let report = TestSuitesXml.readFromFile(reportPath)
    assert(report.tests == 5, "tests count mismatch: ${report.tests}")
    assert(report.failures == 0, "failures count mismatch: ${report.failures}")
    assert(report.errors == 1, "errors count mismatch: ${report.errors}")
    assert(report.skipped == 1, "skipped count mismatch: ${report.skipped}")
    let actualNames = report.testsuites.iterator().map { it => it.name } |> collectArray
    let expectedNames = [
        "a.b.c.Suite1", "a.b.c.Suite2", 
        "a.b.c.Suite3&lt;Int64&gt;", "a.b.c.Suite3&lt;Float64&gt;"
    ]
    assert(actualNames == expectedNames, "suites mismatch: ${actualNames}")
}
