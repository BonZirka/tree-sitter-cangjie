/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


open class A {
    public open func test(a!: Int64 = 1) { 0 }
}
// (not iOS) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_cannot_have_default_param


