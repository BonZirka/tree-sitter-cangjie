/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: other
// EXEC: %compiler %compile_lib_opt -p other
// EXEC-PIPE-1: %compiler %f 2>&1 | compare %f
// ASSERT: regex can not access field 'defaultMember'

import other.Parent

class Child <: Parent {
    func print(): Unit {
        println(super.protectedMember)
        println(super.defaultMember)
        println(super.publicMember)
    }
}
// ASSERT: regex-not no position error occurred
