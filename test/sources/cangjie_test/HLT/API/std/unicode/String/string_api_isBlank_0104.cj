/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.unicode.*

main() {
    let b = ["\u{0009}\u{000A}\u{000B}", "\u{000C}\u{000D}\u{0020}\u{0085}", "\u{00A0}\u{1680}\u{2000}",
        "\u{2002}\u{2003}",
        "\u{2004}\u{2005}\u{2006}\u{2007}\u{2008}\u{2009}\u{200A}\u{2028}\u{2029}\u{202F}\u{202F}\u{205F}\u{3000}"]
    for (i in 0..5 : 1) {
        if (b[i].isBlank() != true) {
            return i + 1
        }
    }
    return 0
}
