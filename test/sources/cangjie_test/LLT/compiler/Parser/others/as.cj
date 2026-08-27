// ERRCHECK: %compiler %cmp_opt %f -o %output %diag_json
// ASSERT: scan-2 parse_invalid_left_hand_expr

open class C {
    var i = 10
}

class B <: C {}

main() {
    let b = B()
    (b as C)?.i = 1
    Some((b as C).getOrThrow()).getOrThrow().i = 1
    (b as C).getOrThrow().i = 1
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
