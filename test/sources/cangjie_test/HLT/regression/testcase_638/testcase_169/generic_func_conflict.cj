/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



open class A {}
class B <: A {}
class C {}
extend C {
   static func f<A>(a: A) {}
}
extend C {
   static func f<X>(a: X) {}
}
// (not iOS) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_extend_member_cannot_shadow
