// EXEC:%frontendCompiler %dump-parse %f 2>&1 | compare %f
// ASSERT: regex-auto expected '{' here
// ASSERT: regex-not Internal Compiler Error
// ASSERT: regex-not core dumped

public enum Time
Unit {
    Year | Month | Hour
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
