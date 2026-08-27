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
	var a = 0x1234p仓颉
	var b = 0b123p仓颉
	var c = 0x124.ac仓颉
	var d = 12.仓颉
	var e = 12.34e仓颉
}
