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
	r'\q'
	r'\w'
	r'\e'
	r'\r'
	r'\t'
	r'\y'
	r'\i'
	r'\o'
	r'\p'
	r'\a'
	r'\s'
	r'\d'
	r'\f'
	r'\g'
	r'\h'
	r'\j'
	r'\k'
	r'\l'
	r'\L'
	r'\z'
	r'\x'
	r'\c'
	r'\v'
	r'\b'
	r'\n'
	r'\m'
}
