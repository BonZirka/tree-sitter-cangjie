// DEPENDENCE: bad_atexcl_macro.pkg.cj
// EXEC: %compiler bad_atexcl_macro.pkg.cj --compile-macro
// ERRCHECK: %compiler %f %cmp_opt 2>&1 

import a.*

@foo func mmm(c: Int) {
    @!bar[2] let v = c 
}

main() {}

// ASSERT: scan error: undeclared identifier 'bar'
// ASSERT: scan 1 error generated, 1 error printed.

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
