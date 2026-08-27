// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: org_name.cj
// EXEC:%compiler %cmp_opt %compile_lib_opt org_name.cj -o org_name.%middle
// (LLVM) EXEC: %compiler %cmp_opt %f org_name.%middle --save-temps . --apc=1 -Woff unused --output-type=staticlib
// (LLVM) EXEC: %llvmDissembler org_name@test_org_name.bc -o %n.ll
// (LLVM) EXEC: %cat %n.ll 2>&1 | compare %f
// (LLVM) ASSERT: scan define void @"_CN22org_name:test_org_name3gooHv"

package org_name::test_org_name
import org_name::pkg_name.*

public func goo() {
    return foo()
}

main() {
    goo()
}
