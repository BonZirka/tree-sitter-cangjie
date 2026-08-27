// EXEC: %compiler %f -o %output
// EXEC-PIPE-0: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan-not exception

internal import std.ast.*

main() {
	let tks2 = quote({ i:M0_<I1_>=>G1_()})
	parseExpr(tks2).toTokens().dump()
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
