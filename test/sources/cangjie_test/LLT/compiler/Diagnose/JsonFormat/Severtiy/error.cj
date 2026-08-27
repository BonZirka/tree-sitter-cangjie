// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler --diagnostic-format=json %n.cj

main()
{
	var a = '\u'
	'\n'
}

/* SCAN-IN
"Severity": "error",
*/
