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
	"\q"
	"\w"
	"\e"
	"\r"
	"\t"
	"\y"
	"\i"
	"\o"
	"\p"
	"\a"
	"\s"
	"\d"
	"\f"
	"\g"
	"\h"
	"\j"
	"\k"
	"\l"
	"\L"
	"\z"
	"\x"
	"\c"
	"\v"
	"\b"
	"\n"
	"\m"
}
