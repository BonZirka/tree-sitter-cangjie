/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_utest_opt

import std.net.*

@Test
class ICMP_socket {
    // need administrator privilege
    @Skip
    @TestCase
    func ipv4_communication(): Unit {
        let server = RawSocket(SocketDomain.IPV4, SocketType.RAW, ProtocolType.ICMP)
        let addr_arr: Array<Byte> = [2, 0, 0, 0, 127, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
        let srv_addr = RawAddress(addr_arr)
        server.bind(srv_addr)
        let client = RawSocket(SocketDomain.IPV4, SocketType.RAW, ProtocolType.ICMP)
        spawn {
            let packet = Array<Byte>(64, repeat: 0)
            packet[0] = 84 // ip->ihl = 5; ip->version = 4;
            packet[1] = 0 // ip->tos = 0;
            packet[2..4] = [28, 0] // ip->tot_len = sizeof(struct iphdr) + sizeof(struct icmphdr);
            packet[4..6] = [57, 48] // ip->id = htons(12345);
            packet[6..8] = [0, 0] // ip->frag_off = 0;
            packet[8] = 64 // ip->ttl = 64;
            packet[9] = 1 // ip->protocol = IPPROTO_ICMP;
            packet[10..12] = [255, 255] // ip->check = checksum((unsigned short*)ip, sizeof(struct iphdr));
            packet[12..16] = [172, 17, 0, 8] // ip->saddr = inet_addr("172.17.0.8");
            packet[16..20] = [127, 0, 0, 1] // ip->daddr = inet_addr(argv[1]);
            packet[20] = 8 // icmp->type = ICMP_ECHO;
            packet[21] = 0 // icmp->code = 0;
            packet[22..24] = [255, 255] // icmp->checksum = checksum((unsigned short*)icmp, sizeof(struct icmphdr));
            packet[24..26] = [0, 0] // icmp->un.echo.id = getpid();
            packet[26..28] = [0, 0] // icmp->un.echo.sequence = 0;
            client.sendTo(srv_addr, packet, Int32(64))
            client.close()
        }
        let msg_arr = Array<Byte>(100, repeat: 0)
        let (client_addr, msg_size) = server.receiveFrom(msg_arr, 0)
        println(client_addr.addr)
        server.close()
        @Expect(msg_size, 84)
    }
}
