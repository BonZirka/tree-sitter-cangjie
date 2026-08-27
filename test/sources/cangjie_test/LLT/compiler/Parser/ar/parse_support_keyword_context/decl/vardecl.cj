// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main() {
    var public = 1
    var private = 2
    var protected = 3
    var (override,abstract, redef) = (4, 5, 6)
    var a = public + private + protected + override + abstract + redef
    return a - 21
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
