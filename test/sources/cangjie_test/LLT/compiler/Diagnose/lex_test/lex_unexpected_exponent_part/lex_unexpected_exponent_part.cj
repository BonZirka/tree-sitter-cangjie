// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.expect.out
// EXEC-1: %compiler %noColor %n.cj > %n.%realOut 2>&1
// EXEC: %diff %n.expect.out %n.%realOut

main()
{
    var a = 0xp
    var v = 0o12p2
    var u = 0b11p2
    var v1 = 0o12e2
    var u1 = 0b11e2
    var a1 = 0x11e2
    var a2 = 11p2
    var a3 = 11ee2
    var a4 = 11.1
    var v1 = 0o12.19p2
var a = 0x-12.2p2
}
