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
	var a = 0x12.34
	var a = 0x12
	var a = 0x.
	var a = 0o12.31
		var a = 0b1.1
var a = 0x12.3.4.5
	var a = 0x.12
	var a = 0x12.
}
