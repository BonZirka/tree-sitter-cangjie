// LEVEL: 0
// EXEC: %compiler %f -o %output

const a = 0 // ok
public const b = 0 // ok

class C {
    static const c = 0 //ok
    var v: Int64
    init() {
        const d = 0 // ok
        v = b + c + d
    }
}

main() {}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
