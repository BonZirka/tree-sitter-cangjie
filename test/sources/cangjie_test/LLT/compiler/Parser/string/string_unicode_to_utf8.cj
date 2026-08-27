// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main() {
    var a = "\u{4f60}\u{5728}\u{54ea}\u{91cc}"
    var b = '\u{4f60}'
    if (a == "你在哪里" && b == '你') {
        return 0
    }
    print("\"\\u{4f60}\\u{5728}\\u{54ea}\\u{91cc}\" => ${a}\n")
    print("\"\\u{4f60}\" => ${b}\n")
    return 1
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
