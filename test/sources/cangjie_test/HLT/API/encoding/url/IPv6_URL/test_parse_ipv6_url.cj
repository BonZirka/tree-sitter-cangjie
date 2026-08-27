/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %cmp_utest_opt  %f -o %output
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.encoding.url.*

@Test
public class Test_IPv6_Cangjie_Httpconnection {
    static var ipv6strs1: Array<String> = [
        "http://[2001:DB8:0:0:8:800:200C:417A]:1/dd",
        "http://[FF01:0:0:0:0:0:0:101]:1/dd",
        "http://[0:0:0:0:0:0:0:1]:1/dd",
        "http://[0:0:0:0:0:0:0:0]:1/dd",
        "http://[ABCD:EF01:2345:6789:ABCD:EF01:2345:6789]:1/dd",
        "http://[2001:DB8:0:0:8:800:200C:417A]:1/dd",
        "http://[2001:DB8::8:800:200C:417A]:1/dd",
        "http://[FF01::101]:1/dd",
        "http://[::1]:1/dd",
        "http://[::]:1/dd",
        "http://[::13.1.68.3]:1/dd",
        "http://[::FFFF:129.144.52.38]:1/dd",
        "http://[::13.1.68.3]/dd"
    ]

    static var ipv6strs2: Array<String> = [
        "https://[::1::]:80/dd",
        "https://[::ffff:256.256.256.256]:80/dd",
        "https://[fe80::1%3\0z]:80/dd",
        "https://[2001:db8::g123:4567:89ab:cdef]:80/dd",
        "https://[2001:db8::H123:4567:89ab:cdef]:80/dd",
        "https://[::::1]:80/dd",
        "https://[0000:0000:0000:0000:0000:0000:0000:0000:000]/dd",
        "https://::13.1.68.3/dd"
    ]

    @TestCase[ipv6str in ipv6strs1 
]
    func test_ipv6_http(ipv6str: String) {
        var url = URL.parse(ipv6str)
    }

    @TestCase[ipv6str in ipv6strs2 
]
    func test_ipv6(ipv6str: String) {
        @AssertThrows[UrlSyntaxException](URL.parse(ipv6str))
    }
}
