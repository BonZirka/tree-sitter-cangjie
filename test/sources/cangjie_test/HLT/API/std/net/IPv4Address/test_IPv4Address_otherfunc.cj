/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.net.*
import std.math.*

@Test
public class Test_IPv4Address_Funcs {
    let All_Str = [
        "192.168.1.1",
        "0.0.0.0",
        "255.255.255.255",
        "223.255.255.255",
        "172.16.0.0",
        "169.254.1.1",
        "127.0.0.1",
        "10.0.0.1",
        "100.64.0.0",
        "192.0.0.8",
        "192.0.0.9",
        "192.0.0.171",
        "192.31.196.0",
        "192.52.193.0",
        "192.88.99.0",
        "192.175.48.0",
        "198.18.0.0",
        "240.0.0.0",
        "203.0.113.0",
        "198.51.100.0"
    ]

    @TestCase[str in All_Str 
]
    func case_writeBigEndian(str: String): Unit {
        var buf = Array<Byte>(16, repeat: 0)
        let addr1 = IPv4Address.readBigEndian(IPAddress.parse(str).getAddressBytes())
        @Expect(addr1.writeBigEndian(buf), 4)
        @Expect(IPv4Address(buf[0], buf[1], buf[2], buf[3]), addr1)
    }

    @TestCase
    func case_hashCode() {
        @Expect(IPv4Address(127, 0, 0, 1).hashCode(), -7046029252255646698)
        @Expect(IPv4Address(0, 0, 0, 0).hashCode(), -7046029254386353131)
    }

    @TestCase[pos_str in All_Str, 
 pre_len in [ 0, 4, 8, 32 ] 
]
    func case_getPrefix_01(pos_str: String, pre_len: UInt8) {
        let addr1 = IPv4Address.readBigEndian(IPAddress.parse(pos_str).getAddressBytes())
        let ip_pre = addr1.getPrefix(pre_len)
        @Expect(addr1.toString(), ip_pre.address.toString())
        @Expect(ip_pre.prefixLength, pre_len)
    }

    @TestCase[pos_str in All_Str, 
 pre_len in [ 33, 128, 255 ] 
]
    func case_getPrefix_02(pos_str: String, pre_len: UInt8) {
        let addr1 = IPv4Address.readBigEndian(IPAddress.parse(pos_str).getAddressBytes())
        @AssertThrows[IllegalArgumentException](addr1.getPrefix(pre_len))
    }

    @TestCase
    func case_toString() {
        @Expect(IPv4Address(0, 0, 0, 0).toString(), "0.0.0.0")
        @Expect(IPv4Address(255, 255, 255, 255).toString(), "255.255.255.255")
        @Expect(IPv4Address(0).toString(), "0.0.0.0")
    }

    @TestCase
    func case_toBits() {
        @Expect(IPv4Address(0, 0, 0, 0).toBits(), 0u32)
        @Expect(IPv4Address(255, 255, 255, 255).toBits(), UInt32.Max)
    }

    @TestCase
    func case_toIPv6Compatible() {
        @Expect(IPv4Address(0, 0, 0, 0).toIPv6Compatible().toString(), "::")
        @Expect(IPv4Address(0, 0, 0, 0).toIPv6Compatible(), (IPAddress.parse("::0.0.0.0") as IPv6Address).getOrThrow())
        @Expect(IPv4Address(127, 0, 0, 1).toIPv6Compatible().toString(), "::7f00:1")
        @Expect(IPv4Address(127, 0, 0, 1).toIPv6Compatible(), (IPAddress.parse("::127.0.0.1") as IPv6Address).getOrThrow())
        @Expect(IPv4Address(255, 255, 255, 255).toIPv6Compatible().toString(), "::ffff:ffff")
        @Expect(IPv4Address(255, 255, 255, 255).toIPv6Compatible(), (IPAddress.parse("::255.255.255.255") as IPv6Address).getOrThrow())
    }

    @TestCase
    func case_toIPv6Mapped() {
        @Expect(IPv4Address(0, 0, 0, 0).toIPv6Mapped().toString(), "::ffff:0.0.0.0")
        @Expect(IPv4Address(0, 0, 0, 0).toIPv6Mapped(), (IPAddress.parse("::ffff:0.0.0.0") as IPv6Address).getOrThrow())
        @Expect(IPv4Address(127, 0, 0, 1).toIPv6Mapped().toString(), "::ffff:127.0.0.1")
        @Expect(IPv4Address(127, 0, 0, 1).toIPv6Mapped(), (IPAddress.parse("::ffff:127.0.0.1") as IPv6Address).getOrThrow())
        @Expect(IPv4Address(255, 255, 255, 255).toIPv6Mapped().toString(), "::ffff:255.255.255.255")
        @Expect(IPv4Address(255, 255, 255, 255).toIPv6Mapped(), (IPAddress.parse("::ffff:255.255.255.255") as IPv6Address).getOrThrow())
    }
}
