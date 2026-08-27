/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt

import std.database.sql.*

@Test
class Test_sqlvarbinary_10 {
    /*
     * Test description:
     *     test value and name of the class SqlVarBinary
     * Test API:
     *     public mut prop value: String
     *     public prop name: String
     */
    @TestCase
    func test_sqlvarbinary_value_name_01(): Unit {
        let sqlvb = SqlVarBinary(Array<Byte>())
        @Expect(sqlvb.value, Array<Byte>())
        @Expect(sqlvb.name, "SqlVarBinary")
        sqlvb.value = Array<Byte>()
        @Expect(sqlvb.value, Array<Byte>())
        @Expect(sqlvb.name,"SqlVarBinary")
    }

    /*
     * Test description:
     *     test value and name of the class SqlVarBinary
     * Test API:
     *     public mut prop value: String
     *     public prop name: String
     */
    @TestCase
    func test_sqlvarbinary_value_name_02(): Unit {
        let sqlvb = SqlVarBinary([0u8, 255u8])
        @Expect(sqlvb.value, [0u8, 255u8])
        @Expect(sqlvb.name, "SqlVarBinary")
        sqlvb.value = Array<Byte>()
        @Expect(sqlvb.value, Array<Byte>())
        @Expect(sqlvb.name,"SqlVarBinary")
    }

    /*
     * Test description:
     *     test value and name of the class SqlVarBinary
     * Test API:
     *     public mut prop value: String
     *     public prop name: String
     */
    @TestCase
    func test_sqlvarbinary_value_name_03(): Unit {
        let sqlvb = SqlVarBinary([0u8, 255u8, 255u8, 255u8, 0u8])
        @Expect(sqlvb.value, [0u8, 255u8, 255u8, 255u8, 0u8])
        @Expect(sqlvb.name, "SqlVarBinary")
        sqlvb.value = Array<Byte>(200, {i => UInt8(i + 1)})
        @Expect(sqlvb.value, Array<Byte>(200, {i => UInt8(i + 1)}))
        @Expect(sqlvb.name,"SqlVarBinary")
    }

    /*
     * Test description:
     *     test value and name of the class SqlVarBinary
     * Test API:
     *     public mut prop value: String
     *     public prop name: String
     */
    @TestCase
    func test_sqlvarbinary_value_name_04(): Unit {
        let sqlvb = SqlVarBinary(Array<Byte>(10000, repeat: 0))
        @Expect(sqlvb.value, Array<Byte>(10000, repeat: 0))
        @Expect(sqlvb.name, "SqlVarBinary")
        sqlvb.value = Array<Byte>(10000, repeat: 255)
        @Expect(sqlvb.value, Array<Byte>(10000, repeat: 255))
        @Expect(sqlvb.name,"SqlVarBinary")
    }
}
