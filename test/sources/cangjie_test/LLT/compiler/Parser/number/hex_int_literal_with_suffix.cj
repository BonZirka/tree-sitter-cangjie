// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix %cmp_utest_opt
// EXEC: %run %run_opt %n.%suffix %run_utest_opt

@Test
class HexIntLiteralsWithSuffix {
    @TestCase
    func hex_int_literal_with_i64_suffix() {
        let x = 0xFA4CE8702A39DCi64
        let y = 0b11111010010011001110100001110000001010100011100111011100_i64

        @PowerAssert(x == y)
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
