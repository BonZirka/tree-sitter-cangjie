// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.lib.cj
// (DEBUG_OPTION)EXEC: %compiler %n.lib.cj %compile_lib_opt -o libdefault.a2.%middle
// (DEBUG_OPTION)EXEC: %compiler %f libdefault.a2.%middle %dumpCHIRDebug
// (DEBUG_OPTION)EXEC: cat default.g1_CHIR/0_AST_CHIR.chir | compare %f
// (Linux and CJNATIVE) EXEC: sed -n -E '/Func @default\.g1_global_init\$\(\)/,/Func @.+\(\)/p' default.g1_CHIR/0_AST_CHIR.chir | compare %n.lib.cj

package default.g1

import default.a2.*

main() {
    var1
}

// ASSERT: regex-not Func @global_init\$_default\.a2\.\d+\.imported_const\.lib\.cj
