// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.expect.out
// EXEC-1: %compiler %noColor %n.cj > %n.%realOut 2>&1
// EXEC: %diff %n.expect.out %n.%realOut

main() {
    var a = 2_EEe1
    var a1 = 0x
    var a2 = 2_E
    var a3 = 0.b
    var a4 = 0x.p2
    var b = 0b
    var c = 0o
    var d = 0.
    var e = .2
    var f = .2e
    var g = 0xp
}
