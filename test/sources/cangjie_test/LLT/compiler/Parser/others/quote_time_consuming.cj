// EXEC: %frontendCompiler %dump-ast %f -o %output 2>&1 | compare %f
// ASSERT: scan-not Struct-Array<Struct-Token>

internal import std.ast.*
main() {
    let tokens = quote(0) 
    println(tokens) 
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
