/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt

import std.database.sql.*

@Test
class Test_sqlnullablevarchar_09 {
    /*
     * Test description:
     *     test value and name of the class SqlNullableVarchar
     * Test API:
     *     public mut prop value: ?String
     *     public prop name: String
     */
    @TestCase
    func test_sqlnullablevarchar_value_name_01(): Unit {
        let sqlnavc = SqlNullableVarchar("")
        @Expect(sqlnavc.value.getOrThrow(), "")
        @Expect(sqlnavc.name, "SqlNullableVarchar")
        sqlnavc.value = "cangjietest"
        @Expect(sqlnavc.value.getOrThrow(), "cangjietest")
        @Expect(sqlnavc.name,"SqlNullableVarchar")
    }

    /*
     * Test description:
     *     test value and name of the class SqlNullableVarchar
     * Test API:
     *     public mut prop value: ?String
     *     public prop name: String
     */
    @TestCase
    func test_sqlnullablevarchar_value_name_02(): Unit {
        let sqlnavc = SqlNullableVarchar("\0")
        @Expect(sqlnavc.value.getOrThrow(), "\0")
        @Expect(sqlnavc.name, "SqlNullableVarchar")
        sqlnavc.value = "12345678"
        @Expect(sqlnavc.value.getOrThrow(), "12345678")
        @Expect(sqlnavc.name,"SqlNullableVarchar")
    }

    /*
     * Test description:
     *     test value and name of the class SqlNullableVarchar
     * Test API:
     *     public mut prop value: ?String
     *     public prop name: String
     */
    @TestCase
    func test_sqlnullablevarchar_value_name_03(): Unit {
        let sqlnavc = SqlNullableVarchar("#$%^&abc")
        @Expect(sqlnavc.value.getOrThrow(), "#$%^&abc")
        @Expect(sqlnavc.name, "SqlNullableVarchar")
        sqlnavc.value = None
        @Expect(sqlnavc.value, None)
        @Expect(sqlnavc.name,"SqlNullableVarchar")
    }

    /*
     * Test description:
     *     test value and name of the class SqlNullableVarchar
     * Test API:
     *     public mut prop value: ?String
     *     public prop name: String
     */
    @TestCase
    func test_sqlnullablevarchar_value_name_04(): Unit {
        let string = StringBuilder(r'1', 10000).toString()
        let string1 = StringBuilder(r'E', 20000).toString()
        let sqlnavc = SqlNullableVarchar(string)
        @Expect(sqlnavc.value.getOrThrow(), string)
        @Expect(sqlnavc.name, "SqlNullableVarchar")
        sqlnavc.value = string1
        @Expect(sqlnavc.value.getOrThrow(), string1)
        @Expect(sqlnavc.name,"SqlNullableVarchar")
    }

    /*
     * Test description:
     *     test value and name of the class SqlNullableVarchar
     * Test API:
     *     public mut prop value: ?String
     *     public prop name: String
     */
    @TestCase
    func test_sqlnullablevarchar_value_name_05(): Unit {
        let sqlnavc = SqlNullableVarchar(None)
        @Expect(sqlnavc.value, None)
        @Expect(sqlnavc.name, "SqlNullableVarchar")
        sqlnavc.value = None
        @Expect(sqlnavc.value, None)
        @Expect(sqlnavc.name,"SqlNullableVarchar")
    }

    /*
     * Test description:
     *     test value and name of the class SqlNullableVarchar
     * Test API:
     *     public mut prop value: ?String
     *     public prop name: String
     */
    @TestCase
    func test_sqlnullablevarchar_value_name_06(): Unit {
        let sqlnavc = SqlNullableVarchar(None)
        @Expect(sqlnavc.value, None)
        @Expect(sqlnavc.name, "SqlNullableVarchar")
        sqlnavc.value = "ABC123abc"
        @Expect(sqlnavc.value.getOrThrow(),"ABC123abc")
        @Expect(sqlnavc.name,"SqlNullableVarchar")
    }
}
