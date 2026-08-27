// EXEC: %compiler %cmp_opt %f -o %output
// EXEC-3: %run %run_opt %output %run_args

sealed abstract class A {}
class sealed <: A {
    public func private() { 1 }
    protected func public() { 2 }
}

main() {
    let open = sealed()
    open.private() + open.public()
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
