// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %mkdir tmps
// EXEC: %compiler %cmp_opt %compile_lib_opt %disableAPC %f %save_temps_opt=tmps
// EXEC: %llvmDissembler tmps/%n.bc -o tmps/%n.ll
// EXEC-PIPE: %cat tmps/%n.ll 2>&1 | compare %f
// ASSERT: regex define void @_CN7default6calleeHv\(\[21 x i8\]\* .* sret\(\[21 x i8\]\) %0\)

enum EA {
    CASE1(Int64, Int32, Bool, Rune)
}

func callee(): EA {
    EA.CASE1(1, 2, true, r'e')
}

func caller() {
    let ret = callee()
    0
}
