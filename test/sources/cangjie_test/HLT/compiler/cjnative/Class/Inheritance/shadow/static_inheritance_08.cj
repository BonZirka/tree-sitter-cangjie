/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt  %compile_lib_opt %f 2>&1 | compare %f

open class Base {
    protected static var test: Array<Bool> = [true]
}

class Data <: Base {
    private static var test: Array<Bool> = [true]
}

main(): Int64 {
    return 1
}
// ASSERT: scan sema_member_variable_can_not_shadow
