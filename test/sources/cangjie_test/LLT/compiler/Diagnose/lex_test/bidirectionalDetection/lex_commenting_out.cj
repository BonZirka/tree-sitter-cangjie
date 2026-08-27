// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.expect.out
// EXEC: %compiler %noColor %n.cj -Woff unused > %n.%realOut 2>&1
// EXEC: %diff %n.expect.out %n.%realOut

main() {
    var isAdmin = false
    /*‮ } ⁦if (isAdmin)⁩ ⁦ begin admins only */
    print("You are an admin.\n")
    /* end admins only ‮ { ⁦*/
    return 0;
}
