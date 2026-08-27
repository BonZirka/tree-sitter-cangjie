// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f
// ASSERT: regex-not Internal Compiler Error
// ASSERT: regex-not core dumped

main(): Int64 {
var a = 0Base // dump
var b = 0xz // dump
var c = 0oase // dump
var c = 0x // dump
return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
