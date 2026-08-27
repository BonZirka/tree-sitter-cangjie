// EXEC: %compiler %f -o %output
// EXEC-PIPE-0: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan-not exception

internal import std.ast.*

main() {
	var tks = cangjieLex("a >>= 1")
	parseExpr(tks)
	tks = cangjieLex("a >= 1")
	parseExpr(tks)
	tks = cangjieLex("a ?? 1")
	parseExpr(tks)
	tks = cangjieLex("a >> 1")
	parseExpr(tks)
	return
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
