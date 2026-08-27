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
	var a = 0b11e1
	var b = 0o11e.12
	var c = 0x11.23p2.
	var d = 0d.e1
	var e = 0d.p1
	var f = 0.e1
	var g = 0.p1
	var h = 0.1p2
	var a = .1p2
	var a = 1p2
}
