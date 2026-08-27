// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

// ASSERT: regex-not core dumped
// ASSERT: regex-not Internal Compiler Error
// ASSERT: scan  A "# B "# C "# 
main() {
    var myVar:String = ###" A "# B "# C "# "###
    println(myVar)
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
