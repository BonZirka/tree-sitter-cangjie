// EXEC: %compiler %noColor -Woff all %n.cj 2>&1
// ASSERT: regex-not error

type `I64` = Int64

main() {
    let b1: I64= 1
    let b2: `I64`= 2
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
