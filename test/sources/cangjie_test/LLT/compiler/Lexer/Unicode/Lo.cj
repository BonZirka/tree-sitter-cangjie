// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %f -Woff unused

main() {
    // \u00b7 is XID_Continue
    var _· = 1
    var a_· = 2
    var a· = 3

    `a·` = 4

    // \u00ba is XID_Start
    var ºº = 2
    var aº = 3
    `ºº` = 4
    var º = 5
    var º_º = 6
}
